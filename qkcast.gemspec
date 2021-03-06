# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qkcast/version'

Gem::Specification.new do |spec|
  spec.name          = "qkcast"
  spec.version       = Qkcast::VERSION
  spec.authors       = ["Diego Guerra"]
  spec.email         = ["diego.guerra.suarez@gmail.com"]
  spec.description   = "Quickly generate a podcast rss from a dir of files"
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'erubis'
  spec.add_dependency 'rack'
  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
