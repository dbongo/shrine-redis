# Shrine::Storage::Redis

Provides a Shrine Storage for storing files in Redis.

## Installation

```ruby
gem "shrine-redis"
```

## Usage

```rb
# This example assumes a redis-server instance is running in the background

require "redis"
require "shrine"
require "shrine/storage/redis"

redis = Redis.new

cache = { client: redis, prefix: "cache", expire: 60 }
store = { client: redis, prefix: "store", expire: 3600 }

Shrine.storages = {
  cache: Shrine::Storage::Redis.new(cache),
  store: Shrine::Storage::Redis.new(store)
}
```

## Contributing

You can run the tests with Rake:
```sh
$ bundle exec rake test
```

## License

[MIT](http://opensource.org/licenses/MIT)
