require 'hanami/interactor'

class FacebookLogin
  include Hanami::Interactor

  expose :token

  def initialize(params)
    @params = params
  end

  def call
    facebook_data = FacebookData.new(@params.get(:access_token)).call

    if facebook_data.successful?
      account = account_repo.find_by_email(facebook_data.email)

      account_id = if account
        account.id
      else
        account_repo.create(email: facebook_data.email).id
      end

      SetAccountProvider.new({
        id:           account_id,
        access_token: @params.get(:access_token)
      }).call

      payload = { account_id: account_id }

      @token = JWT.encode(payload, ENV['JWT_SECRET'], ENV['JWT_ALGORITHM'])
    else
      error!(facebook_data.error)
    end
  end

  private

  def valid?
    if @params.valid?
      super
    else
      error!('Missing access token.')
    end
  end

  def account_repo
    @account_repo ||= AccountRepository.new
  end
end
