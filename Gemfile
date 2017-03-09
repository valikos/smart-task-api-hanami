source 'https://rubygems.org'
ruby '2.4.0'

gem 'rake'
gem 'hanami',       '1.0.0.beta2'
gem 'hanami-model', '1.0.0.beta2'

gem 'rodauth'
gem 'cors'
gem 'jwt'
gem 'bcrypt'
gem 'pg'
gem 'jsonapi-serializers'
gem 'rack-cors', require: 'rack/cors'
# TODO: Wait for stable hanami release
# gem 'newrelic-hanami', git: 'https://github.com/valikos/newrelic-hanami.git',
#                        branch: 'feature/support-hanami-9'
gem 'koala', '~> 2.2'

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
  gem 'puma'
end
