# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum_stat/version'

Gem::Specification.new do |spec|
  spec.name          = "enum_stat"
  spec.version       = EnumStat::VERSION
  spec.authors       = ['moonfly (Andrey Pronin)']
  spec.email         = ['moonfly.msk@gmail.com']
  spec.summary       = %q{Additional statistical methods for enumerable objects}
  spec.description   = %q{Additional statistical methods for enumerable objects}
  spec.homepage      = 'https://github.com/moonfly/' + spec.name
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'coveralls'
end
