require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/smart_task_api'
require_relative '../apps/auth/application'
require_relative '../apps/api/application'
require_relative '../apps/web/application'

Hanami::Container.configure do
  mount Auth::Application, at: '/auth'
  mount Api::Application,  at: '/api'
  mount Web::Application,  at: '/'
end
