# encoding: UTF-8

require 'json-write-stream'
require 'rosette/serializers/serializer'

module Rosette
  module Serializers

    class JsonSerializer < Serializer
      attr_reader :writer

      def initialize(stream, locale, encoding = Encoding::UTF_8)
        super
        @writer = JsonWriteStream.from_stream(stream, encoding)
      end

      def write_raw(text)
        writer.stream.write(text)
      end

      def flush
        writer.flush
        stream.flush
      end

      def self.default_extension
        '.json'
      end

      class KeyValueSerializer < JsonSerializer
        def initialize(stream, locale, encoding = Encoding::UTF_8)
          super
          writer.write_object
        end

        def write_key_value(key, value)
          writer.write_key_value(
            key.encode(encoding), value.encode(encoding)
          )
        end
      end
    end

  end
end
