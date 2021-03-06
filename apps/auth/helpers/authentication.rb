require_relative './empty_rodauth'

module Auth
  module Authentication
    def self.included(action)
      action.class_eval do
        # before :authenticate!
        expose :account
        expose :current_user
      end
    end

  private

    # def authenticate!
    #   rodauth
    #   unless authenticated?
    #     session[:previous_path] = request.path
    #     redirect_to rodauth.login_route
    #   end
    # end

    # def authenticated?
    #   rodauth.authenticated?
    # end

    def current_user
      @current_user ||= account
    end

    def account
      @account ||= AccountRepository.find(rodauth.account_id)
    end

    def rodauth
      request.env['rodauth'] || Auth::EmptyRodauth.new
    end
  end
end