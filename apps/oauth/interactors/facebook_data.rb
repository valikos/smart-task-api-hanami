require 'hanami/interactor'

class FacebookData
  include Hanami::Interactor

  expose :email

  def initialize(token)
    @token = token
  end

  def call
    begin
      graph = Koala::Facebook::API.new(@token, ENV['FACEBOOK_SECRET'])

      token_data = graph.debug_token(@token)['data']

      if token_data.fetch('is_valid')
        @email = graph.get_object('me', fields: 'email').fetch('email')
      else
        error!(@token_data.fetch('error').fetch('message'))
      end
    rescue Koala::Facebook::AuthenticationError => e
      error!(e.fb_error_message)
    end
  end
end
