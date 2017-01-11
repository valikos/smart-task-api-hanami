require 'roda'

module Api
  class Rodauth < Roda
    DB = Sequel.connect(ENV['DATABASE_URL'])

    plugin :middleware

    plugin :rodauth, json: :only do
      enable :jwt

      jwt_secret ENV['JWT_SECRET']
    end

    route do |r|
      r.rodauth
      rodauth.require_authentication
      env['rodauth'] = rodauth
    end
  end
end
