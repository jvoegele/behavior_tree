# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'behavior_tree/version'

Gem::Specification.new do |spec|
  spec.name          = "behavior_tree"
  spec.version       = BehaviorTree::VERSION
  spec.authors       = ["Jason Voegele"]
  spec.email         = ["jason@jvoegele.com"]
  spec.description   = %q{Implementation of the Behavior Tree concept in Ruby}
  spec.summary       = %q{Implementation of the Behavior Tree concept in Ruby}
  spec.homepage      = "https://github.com/jvoegele/behavior_tree"
  spec.license       = "Apache v2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
