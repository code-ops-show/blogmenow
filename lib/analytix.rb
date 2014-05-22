module Analytix
  module Model
    extend ActiveSupport::Concern

    def track *stats
      $analytix.pipelined do 
        stats.each { |stat| track_for(stat) }
      end
    end

    def track_for stat
      { symbol: -> { send(stat) },
        array:  -> { send(stat[0], stat[1])}
      }.freeze[stat.class.name.underscore.to_sym].call
    end

  private

    def views
      $analytix.incr Key.build_for :views, self
    end

    def uniques data
      $analytix.sadd Key.build_for(:uniques, self), data
    end
  end

  module Key
    def self.build_for stat, object
      date = Date.today

      [date.year, date.month, date.day,
       object.class.name.underscore, object.id, stat].join(':')
    end
  end
end