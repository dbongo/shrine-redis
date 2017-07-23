# Shrine::Storage::RedisStorage

Provides a Shrine Storage for storing files in Redis.

## Installation

```ruby
gem 'shrine-redis'
```

## Usage

```rb
require "shrine/storage/redis_storage"
require "redis"

redis = Redis.new(url: "redis://host:port/db")

Shrine.storages = {
  :cache: Shrine::Storage::RedisStorage.new(
    redis,
    prefix: 'cache',
    expire: 60
  ),
  store: Shrine::Storage::RedisStorage.new(
    redis,
    prefix: 'store',
    expire: 3600
  )
}
```

## Contributing

You can run the tests with Rake:
```sh
$ bundle exec rake test
```

## License

[MIT](http://opensource.org/licenses/MIT)
