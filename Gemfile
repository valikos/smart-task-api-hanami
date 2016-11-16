source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.8.0'
gem 'hanami-model', '~> 0.6.0'
gem 'rodauth'
gem 'cors'
gem 'jwt'
gem 'bcrypt'
gem 'pg'
gem 'jsonapi-serializers'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'thin'
  gem 'dotenv', '~> 2.0'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'database_cleaner'
end

group :production do
  # gem 'puma'
end
