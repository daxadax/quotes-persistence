# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'persistence/version'

Gem::Specification.new do |spec|
  spec.name          = "persistence"
  spec.version       = Persistence::VERSION
  spec.authors       = ["Dax"]
  spec.email         = ["d.dax@email.com"]
  spec.summary       = %q{persistence for quotes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sequel'
  spec.add_dependency 'mysql2'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "minitest-spec"
  spec.add_development_dependency "rake"
end
