require 'roda'

module Auth
  class Rodauth < Roda
    DB = Sequel.connect(ENV['DATABASE_URL'])

    plugin :middleware

    plugin :rodauth, json: :only do
      enable :login, :logout, :jwt, :create_account

      jwt_session_hash do
        super().merge(exp: Time.now.to_i + 15 * 3600)
      end

      jwt_secret ENV['JWT_SECRET']
    end

    route do |r|
      r.rodauth

      env['rodauth'] = rodauth
    end
  end
end
