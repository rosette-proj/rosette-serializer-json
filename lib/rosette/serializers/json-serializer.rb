# encoding: UTF-8

require 'json-write-stream'
require 'rosette/serializers/serializer'

module Rosette
  module Serializers

    class JsonSerializer < Serializer
      attr_reader :stream, :writer, :encoding

      def initialize(stream, encoding = Encoding::UTF_8)
        @stream = stream
        @encoding = encoding
        @writer = JsonWriteStream.from_stream(stream, encoding)
        after_initialize
      end

      def flush
        writer.flush
        stream.flush
      end

      def default_extension
        '.json'
      end

      class KeyValueSerializer < JsonSerializer
        def after_initialize
          writer.write_object
        end

        def write_translation(trans)
          key = trans.phrase.index_value
          writer.write_key_value(key, trans.translation)
        end
      end
    end

  end
end
