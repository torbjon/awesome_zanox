# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awesome_zanox/version'

Gem::Specification.new do |spec|
  spec.name          = 'awesome_zanox'
  spec.version       = AwesomeZanox::VERSION
  spec.authors       = ['Maksim Berjoza']
  spec.email         = ['torbjon@gmail.com']
  spec.summary       = 'Zanox.com SOAP client'
  spec.description   = 'Zanox.com SOAP client'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'savon', '~> 2.6.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10.0'
end
