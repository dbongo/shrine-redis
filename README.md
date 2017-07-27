# Shrine::Storage::Redis

Provides a Shrine Storage for storing files in Redis.

## Installation

```ruby
gem "shrine-redis"
```

## Usage

```rb
require "shrine/storage/redis"

redis = Redis.new(url: "redis://host:port/db")

Shrine.storages = {
  cache: Shrine::Storage::Redis.new(
    client: redis,
    prefix: "cache",
    expire: 60
  ),
  store: Shrine::Storage::Redis.new(
    client: redis,
    prefix: "store",
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
