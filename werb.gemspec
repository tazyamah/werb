# -*- encoding: utf-8 -*-
require File.expand_path('../lib/werb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tatsuya Suzuki"]
  gem.email         = ["tazyamah@gmail.com"]
  gem.description   = %q{web framework likes naked php.}
  gem.summary       = %q{werb erb web framework}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "werb"
  gem.require_paths = ["lib"]
  gem.version       = Werb::VERSION

  gem.add_dependency 'rack', '~> 1.0.0'
end
