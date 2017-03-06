require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/smart_task_api'
# require_relative '../apps/web/application'
require_relative '../apps/oauth/application'
require_relative '../apps/auth/application'
require_relative '../apps/api/application'

Hanami.configure do
  # mount Web::Application,   at: '/'
  mount OAuth::Application, at: '/o'
  mount Auth::Application,  at: '/auth'
  mount Api::Application,   at: '/api'

  model do
    adapter :sql, ENV['DATABASE_URL']

    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root Hanami.root.join("lib", "smart_task_api", "mailers")

    # This has changed. It used to be a block, now it's a setting
    delivery :test
  end

  # These two blocks are new.
  # They MUST be after the general settings like `mount`, `model`, `mailer`.
  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :info
  end

  environment :production do
    logger level: :info, formatter: :json

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
