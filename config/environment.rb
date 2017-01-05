require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/smart_task_api'
require_relative '../apps/oauth/application'
require_relative '../apps/auth/application'
require_relative '../apps/api/application'

DB = Sequel.connect(ENV['DATABASE_URL'])

# This used to be `Hanami::Container.configure`, now it must be `Hanami.configure`
Hanami.configure do
  mount OAuth::Application, at: '/o'
  mount Auth::Application, at: '/auth'
  mount Api::Application,  at: '/api'

  # This is a new block
  #
  # Cut and paste the contents of `Hanami::Model.configure` from lib/bookshelf.rb
  model do

    # This used to be:
    #
    #   adapter type: :sql, url: ENV['DATABASE_URL']
    adapter :sql, ENV['DATABASE_URL']

    migrations 'db/migrations'
    schema     'db/schema.sql'

    #
    # Mapping block isn't supported anymore
    #
  end

  # This is a new block
  #
  # Cut and paste the contents of `Hanami::Mailer.configure` from lib/bookshelf.rb
  mailer do

    # Adjust the new layer `root` location
    root Hanami.root.join("lib", "bookshelf", "mailers")

    delivery do
      development :test
      test        :test
      # production :smtp, address: ENV['SMTP_PORT'], port: 1025
    end
  end
end
