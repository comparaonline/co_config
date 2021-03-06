# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'co_config/version'

Gem::Specification.new do |spec|
  spec.name          = "co_config"
  spec.version       = CoConfig::VERSION
  spec.authors       = ["Ezequiel Rabinovich"]
  spec.email         = ["erabinovich@gmail.com"]

  spec.summary       = %q{Simple configuration management gem.}
  spec.description   =  <<-EOF.gsub(/^\s{4}/, '')
    Simple configuration management. For a description on
    how to use this gem please check the readme file on
    https://github.com/comparaonline/co_config/blob/master/README.md
  EOF
  spec.homepage      = "https://github.com/comparaonline/co_config"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0', '< 5'
  spec.add_dependency 'rails', '>= 3.0', '< 5'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3"
end
