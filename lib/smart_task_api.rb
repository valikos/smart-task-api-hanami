require 'hanami/model'
require 'hanami/mailer'
Dir["#{ __dir__ }/smart_task_api/**/*.rb"].each { |file| require_relative file }

Hanami::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * File System adapter
  #    adapter type: :file_system, uri: 'file:///db/bookshelf_development'
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/smart_task_api_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/smart_task_api_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/smart_task_api_development'
  #    adapter type: :sql, uri: 'mysql://localhost/smart_task_api_development'
  #
  adapter type: :sql, uri: ENV['DATABASE_URL']

  ##
  # Migrations
  #
  migrations 'db/migrations'
  schema     'db/schema.sql'

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  mapping do
    # collection :users do
    #   entity     User
    #   repository UserRepository
    #
    #   attribute :id,   Integer
    #   attribute :name, String
    # end

    collection :accounts do
      entity     Account
      repository AccountRepository

      attribute :id,    Integer
      attribute :email, String
    end

    collection :projects do
      entity     Project
      repository ProjectRepository

      attribute :id,         Integer
      attribute :account_id, Integer

      attribute :title,      String
    end
  end
end.load!

Hanami::Mailer.configure do
  root "#{ __dir__ }/smart_task_api/mailers"

  # See http://hanamirb.org/guides/mailers/delivery
  delivery do
    development :test
    test        :test
    # production :smtp, address: ENV['SMTP_PORT'], port: 1025
  end
end.load!
