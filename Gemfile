source 'https://rubygems.org'
ruby '~> 2.3.0'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.9'
gem 'hanami-model', '~> 0.7'
gem 'rodauth'
gem 'cors'
gem 'jwt'
gem 'bcrypt'
gem 'pg'
gem 'jsonapi-serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'newrelic-hanami', git: 'https://github.com/valikos/newrelic-hanami.git',
                       branch: 'feature/support-hanami-9'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'database_cleaner'
end

group :production do
  gem 'thin'
end
