# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ef2/version'

Gem::Specification.new do |spec|
  spec.name = "ef2"
  spec.version = Ef2::VERSION
  spec.authors = ["Tim B."]

  spec.summary = 'A tool for modelling and automating Amazon Fresh orders'
  spec.description = 'Eliminate the operational burden of supporting your household by automating the deployment of your Amazon Fresh orders.'
  spec.homepage = 'https://github.com/Tim-B/ef2'
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "bin"
  spec.executables << 'ef2'
  spec.require_paths = ["lib"]

  spec.add_dependency 'mechanize', '~> 2.7', '>= 2.7.4'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'powerbar', '~> 1.0', '>= 1.0.17'
  spec.add_dependency 'launchy', '~> 2.4', '>= 2.4.3'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
