# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/telefonica/version'

Gem::Specification.new do |spec|
  spec.name          = "fog-telefonica"
  spec.version       = Fog::TeleFonica::VERSION
  spec.authors       = ["Matt Darby"]
  spec.email         = ["matt.darby@rackspace.com"]

  spec.summary       = %q{TeleFonica fog provider gem}
  spec.description   = %q{TeleFonica fog provider gem.}
  spec.homepage      = "https://github.com/fog/fog-telefonica"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_dependency 'fog-core',  '>= 1.45', '<=2.1.0'
  spec.add_dependency 'fog-json',  '>= 1.0'
  spec.add_dependency 'ipaddress', '>= 0.8'

  spec.add_development_dependency 'bundler', '~> 1'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency "mime-types"
  spec.add_development_dependency "mime-types-data"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'shindo',  '~> 0.3'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock',  '~> 1.24.6'
end
