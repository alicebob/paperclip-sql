# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = "paperclip-sql"
  gem.version       = "0.0.2"

  gem.homepage      = "https://github.com/alicebob/paperclip-sql"
  gem.description   = %q{Extends Paperclip with SQL storage.}
  gem.summary       = gem.description
  gem.authors       = ["Harmen"]
  gem.email         = []

  gem.files         = Dir["lib/**/*"] + ["README.md", "LICENSE", "paperclip-sql.gemspec"]
  gem.require_path  = "lib"

  gem.required_ruby_version = ">= 1.9.2"

  gem.license       = "MIT"

  gem.add_dependency "paperclip", ">= 3.1"

  gem.add_development_dependency "activerecord", ">= 3.2"
end
