require "shrine"
require "redis"

require "stringio"

class Shrine
  module Storage
    class Redis
      attr_reader :redis, :prefix, :expire

      def initialize(client: nil, prefix: nil, expire: nil, **options)
        @redis = client || ::Redis.new(options)
        @prefix = prefix
        @expire = expire
        raise ArgumentError, 'Missing redis client' unless @redis.is_a?(::Redis)
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

      def multi_delete(ids)
        if ids.is_a?(Array)
          ids.each { |id| delete(id) }
        elsif ids.is_a?(String)
          redis.del(keys(ids)) unless keys(ids).empty?
        end
      end

      private

      def content(id)
        redis.get(key(id)).to_s
      end

      def keys(id)
        redis.keys(key(id))
      end

      def key(id)
        [*prefix, id].join(":")
      end
    end
  end
end
