module CreateAccountHelper
  def create_account(options = {})
    params = {
      login:              'testing@email.com',
      password:           'password',
      'login-confirm':    'testing@email.com',
      'password-confirm': 'password'
    }

    xhr_post('/auth/create-account', params)

    last_response.header['Authorization']
  end
end
