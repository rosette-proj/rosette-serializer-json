# encoding: UTF-8

require 'spec_helper'
require 'json'

include Rosette::Serializers

# NOTE: The use of YAML in these specs is only to make writing multi-line
# indented strings easier to read and write
describe JsonSerializer::KeyValueSerializer do
  let(:stream) { StringIO.new }
  let(:locale) { Rosette::Core::Locale.parse('fr-FR') }

  let(:serializer) do
    JsonSerializer::KeyValueSerializer.new(stream, locale)
  end

  def serialize
    yield
    serializer.flush
    stream.string
  end

  it 'writes key/value pairs' do
    result = serialize do
      serializer.write_key_value('foo', 'bar')
    end

    expect(result).to eq('{"foo":"bar"}')
  end
end
