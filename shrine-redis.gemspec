Gem::Specification.new do |spec|
  spec.name                  = "shrine-redis"
  spec.version               = "1.0.2"
  spec.summary               = "Redis storage interface for Shrine."
  spec.homepage              = "https://github.com/dbongo/shrine-redis"
  spec.license               = "MIT"
  spec.authors               = ["Michael Crowther"]
  spec.email                 = ["crow404@gmail.com"]
  spec.files                 = Dir["README.md", "LICENSE.txt", "lib/**/*.rb", "shrine-redis.gemspec"]
  spec.require_path          = "lib"
  spec.required_ruby_version = ">= 2.1"

  spec.add_dependency "shrine", "~> 2.0"
  spec.add_dependency "redis", "~> 3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
