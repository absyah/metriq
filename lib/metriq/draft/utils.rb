module Metriq
  module Draft
    class Utils

      attr_reader :key

      def initialize(key)
        @key = key
      end

      def write(value)
        data = (value.presence||{}).to_json
        redis.set(key, data)
      end

      def read
        data = redis.get(key).presence || {}.to_json
        JSON.parse(data).with_indifferent_access
      end

      def clear
        redis.del(key)
      end

      private

      def redis
        @redis ||= if redis_password
          Redis::Namespace.new(redis_namespace, redis: Redis.new(url: redis_url, password: redis_password))
        else
          Redis::Namespace.new(redis_namespace, redis: Redis.new(url: redis_url))
        end
      end

      def redis_url
        "#{ENV['METRIQ_REDIS_URL']}/#{ENV['METRIQ_REDIS_DATABASE']}"
      end

      def redis_namespace
        ENV['METRIQ_REDIS_NAMESPACE'] || 'metriq'
      end

      def redis_password
        ENV['METRIQ_REDIS_PASSWORD']
      end
    end
  end
end
