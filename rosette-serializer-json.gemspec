$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/serializers/json/version'

Gem::Specification.new do |s|
  s.name     = 'rosette-serializer-json'
  s.version  = ::Rosette::JsonSerializerVersion::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron'

  s.description = s.summary = 'A streaming JSON serializer for the Rosette internationalization platform.'

  s.add_dependency 'json-write-stream', '~> 1.0.2'

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", 'Gemfile', 'History.txt', 'README.md', 'Rakefile', 'rosette-serializer-json.gemspec']
end
