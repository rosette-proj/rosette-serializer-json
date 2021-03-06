[![Build Status](https://travis-ci.org/rosette-proj/rosette-serializer-json.svg)](https://travis-ci.org/rosette-proj/rosette-serializer-json) [![Code Climate](https://codeclimate.com/github/rosette-proj/rosette-serializer-json/badges/gpa.svg)](https://codeclimate.com/github/rosette-proj/rosette-serializer-json) [![Test Coverage](https://codeclimate.com/github/rosette-proj/rosette-serializer-json/badges/coverage.svg)](https://codeclimate.com/github/rosette-proj/rosette-serializer-json/coverage)

rosette-serializer-json
====================

Provides a way of writing JSON files from lists of translations for the Rosette internationalization platform.

## Installation

`gem install rosette-serializer-json`

Then, somewhere in your project:

```ruby
require 'rosette/serializers/json-serializer'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform. rosette-serializer-json is capable of writing translations in JSON file format, specifically those that use the structure of one of the following:

1. Basic key/value pairs (i.e. a JSON object).

Additional types of JSON structure are straightforward to support. Open an issue or pull request if you'd like to see support for another structure.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding JSON key/value serialization support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/serializer/json-serializer'

rosette_config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo.add_serializer('json', format: 'json/key-value')
  end
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

Serializers support a set of configuration options, including adding pre-processors. Preprocessors are applied before translations are serialized. Adding the [normalization pre-processor](https://github.com/rosette-proj/rosette-preprocessor-normalization), for example, looks like this:

```ruby
repo.add_serializer('json', format: 'json/key-value') do |serializer_config|
  serializer_config.add_preprocessor('normalization') do |pre_config|
    pre_config.set_normalization_form(:nfc)
  end
end
```

### Standalone Usage

While most of the time rosette-serializer-json will probably be used alongside rosette-server (or similar), there may arise use cases where someone might want to use it on its own. The `write_key_value` method on `KeyValueSerializer` writes a key/value pair to the underlying stream:

```ruby
stream = StringIO.new
locale = Rosette::Core::Locale.parse('ja-JP')
serializer = Rosette::Serializer::JsonSerializer::KeyValueSerializer.new(stream, locale)

serializer.write_key_value('foo', 'bar')
serializer.flush

# {"foo":"bar"}
stream.string
```

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
