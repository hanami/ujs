# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hanami/ujs/version"

Gem::Specification.new do |spec|
  spec.name          = "hanami-ujs"
  spec.version       = Hanami::UJS::VERSION
  spec.authors       = ["Luca Guidi"]
  spec.email         = ["me@lucaguidi.com"]

  spec.summary       = "Hanami UJS"
  spec.description   = "Hanami Unobtrusive JavaScript"
  spec.homepage      = "http://hanamirb.org"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.files         = `git ls-files -- lib/* CHANGELOG.md LICENSE.md README.md hanami-ujs.gemspec`.split($INPUT_RECORD_SEPARATOR)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.6", "< 3"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.7"
end
