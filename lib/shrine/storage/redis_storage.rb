require "shrine"
require "redis"

require "stringio"

class Shrine
  module Storage
    class RedisStorage
      attr_reader :redis, :prefix, :expire

      def initialize(redis, prefix:, expire:)
        @redis = redis
        @prefix = prefix
        @expire = expire
        raise ArgumentError, 'Missing redis client' unless redis && redis.is_a?(Redis)
      end

      def upload(io, id, shrine_metadata: {}, **upload_options)
        if expire
          redis.setex(key(id), expire, io.read)
        else
          redis.set(key(id), io.read)
        end
      end

      def url(id, **options)
      end

      def open(id)
        redis.expire(key(id), expire) if expire
        StringIO.new(content(id))
      end

      def exists?(id)
        redis.exists(key(id))
      end

      def delete(id)
        redis.del(key(id))
      end

      def clear!
        redis.flushdb
      end

      private

      def content(id)
        redis.get(key(id)).to_s
      end

      def key(id)
        if prefix
          "#{prefix}:#{id}"
        else
          "#{id}"
        end
      end
    end
  end
end
