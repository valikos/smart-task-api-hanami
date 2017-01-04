module OAuth::Controllers::Facebook
  class Token
    include OAuth::Action

    params do
      required(:access_token).filled
    end

    def call(params)
      result = FacebookLogin.new(params).call

      if result.successful?
        self.status = 200
        self.body   = 'Ok'
        self.headers.merge!({ 'Authorization' => result.token })
      else
        halt 400, result.error
      end
    end
  end
end
