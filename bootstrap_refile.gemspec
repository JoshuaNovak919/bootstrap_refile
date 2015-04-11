# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bootstrap_refile/version'

Gem::Specification.new do |spec|
  spec.name          = "bootstrap_refile"
  spec.version       = BootstrapRefile::VERSION
  spec.authors       = ["Joshua Novak"]
  spec.email         = ["JoshuaNovak919@gmail.com"]
  spec.summary       = "A bootstrap styled single uploader for refile."
  spec.description   = "A bootstrap styled single uploader for refile."
  spec.homepage      = "https://github.com/JoshuaNovak919/bootstrap_refile"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 3.1"
  spec.add_dependency "refile"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end