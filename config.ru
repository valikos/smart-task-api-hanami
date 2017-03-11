require './config/environment'
# require 'newrelic_rpm'
# require 'newrelic-hanami'

# NewRelic::Agent.manual_start

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization']
  end
end

run Hanami.app
