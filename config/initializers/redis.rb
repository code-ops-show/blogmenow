r = Redis.new

$analytix = Redis::Namespace.new([Rails.env, 'analytix'].join(':'), redis: r)