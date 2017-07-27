Gem::Specification.new do |gem|
  gem.name         = "shrine-redis"
  gem.version      = "1.0.0"

  gem.required_ruby_version = ">= 2.1"

  gem.summary      = "Provides Redis storage for Shrine."
  gem.homepage     = "https://github.com/dbongo/shrine-redis"
  gem.authors      = ["Michael Crowther"]
  gem.email        = ["crow404@gmail.com"]
  gem.license      = "MIT"
  gem.files        = Dir["README.md", "LICENSE.txt", "lib/**/*.rb", "shrine-redis.gemspec"]
  gem.require_path = "lib"

  gem.add_dependency "shrine", "~> 2.0"
  gem.add_dependency "redis", "~> 3.2"

  gem.add_development_dependency "bundler", "~> 1.15"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "minitest", "~> 5.0"
end
