module Api
  module Authentication

    def self.included(action)
      action.class_eval do
        expose :account
        expose :current_user
      end
    end

    private

    def rodauth
      request.env['rodauth']
    end

    def account_id
      rodauth.session_value
    end

    def current_user
      @current_user ||= AccountRepository.find(account_id)
    end
  end
end
