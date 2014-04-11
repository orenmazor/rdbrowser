# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdbrowser/version'

Gem::Specification.new do |spec|
  spec.name          = "rdbrowser"
  spec.version       = Rdbrowser::VERSION
  spec.authors       = ["Oren Mazor"]
  spec.email         = ["oren.mazor@gmail.com"]
  spec.summary       = %q{Manually parse an RDB file linearly without loading the full thing.}
  spec.description   = %q{Manually parse an RDB file linearly without loading the full thing.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"
end
