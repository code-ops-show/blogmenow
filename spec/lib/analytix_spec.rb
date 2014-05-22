require 'spec_helper'
require 'analytix'

module Analytix
  describe Model do 
    let(:klass_name) { double("Object", { name: "Post" }) }
    let(:post)       { double(Post, { id: 1, class: klass_name }).extend(Model) }

    before do 
      keys = $analytix.keys('*')
      $analytix.del(keys) if keys.present?
    end

    describe "#track" do 
      it "should call the correct method when just symbol" do 
        post.track(:views).should eq [1]
        post.track(:views).should eq [2]
      end

      it "should call the correct method when just array" do 
        post.track([:uniques, "127.0.0.1"]).should eq [true]
        post.track([:uniques, "127.0.0.1"]).should eq [false]
      end

      it "should return multiple results with multiple stats" do 
        post.track(:views, [:uniques, "127.0.0.1"]).should eq [1, true]
        post.track(:views, [:uniques, "127.0.0.1"]).should eq [2, false]
      end
    end

    describe "#track_for" do 
      it "should call the :views method when symbol" do
        post.should_receive(:views).once
        post.track_for :views
      end

      it "should call the :uniques method when array" do 
        post.should_receive(:uniques).with('127.0.0.1').once
        post.track_for [:uniques, '127.0.0.1']
      end
    end
  end

  describe Key do 
    let(:klass_name) { double("Object", { name: "Post" }) }
    let(:post)       { double(Post, { id: 1, class: klass_name })}
    let(:date)       { Date.today }

    let(:views_key)  { "#{date.year}:#{date.month}:#{date.day}:post:1:views" }

    describe "#build_for" do 
      it "should create key for :views" do 
        expect(Key.build_for(:views, post)).to eq views_key
      end 
    end 
  end
end