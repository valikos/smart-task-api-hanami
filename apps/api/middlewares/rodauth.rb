require 'roda'

module Api
  class Rodauth < Roda
    DB = Sequel.connect(ENV['DATABASE_URL'])

    plugin :middleware

    plugin :rodauth, json: :only do
      enable :jwt

      # account_password_hash_column :password_hash

      jwt_secret 'lorem'
    end

    route do |r|
      r.rodauth
      rodauth.require_authentication
      env['rodauth'] = rodauth
    end
  end
end
