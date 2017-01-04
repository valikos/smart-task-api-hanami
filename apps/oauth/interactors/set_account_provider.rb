require 'hanami/interactor'

class SetAccountProvider
  include Hanami::Interactor

  def initialize(options = {})
    @id           = options.fetch(:id)
    @access_token = options.fetch(:access_token)
    @provider     = options.fetch(:provider, 'facebook')
  end

  def call
    if repo.find(@id)
      repo.update(@id, {
        provider:     @provider,
        access_token: @access_token
      })
    else
      repo.create(
        id:           @id,
        provider:     @provider,
        access_token: @access_token
      )
    end
  end

  private

  def repo
    @repo ||= AccountProviderRepository.new
  end
end
