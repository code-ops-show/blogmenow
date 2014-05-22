class Post < ActiveRecord::Base
  include Analytix::Model
    
  validates :title, presence: true
  has_many :comments
end
