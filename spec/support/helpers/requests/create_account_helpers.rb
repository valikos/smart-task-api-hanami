module CreateAccountHelper
  def create_account(options = {})
    params = {
      login:              'testing@email.com',
      password:           'password',
      'login-confirm':    'testing@email.com',
      'password-confirm': 'password'
    }

    endpoint = "/auth/create-account?#{Rack::Utils.build_query(params)}"

    post(endpoint, {}, { "CONTENT_TYPE" => "application/json" })

    last_response.header['Authorization']
  end
end
