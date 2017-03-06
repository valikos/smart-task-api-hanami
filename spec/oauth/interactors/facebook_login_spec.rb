require_relative '../../../apps/oauth/interactors/facebook_login'

JWT_PATTERN = /\A[a-zA-Z0-9\-_]+?\.[a-zA-Z0-9\-_]+?\.[a-zA-Z0-9\-_]+?\z/

RSpec.describe FacebookLogin do
  let(:subject) { described_class.new(params) }
  let(:params) { double('params', valid?: params_status) }
  let(:params_status) { true }
  let(:facebook_data) { double('FacebookData::Instance') }
  let(:facebook_data_result) { double('FacebookData::Result') }
  let(:set_account_provider) { double(SetAccountProvider) }

  before do
    allow(FacebookData).to receive(:new).and_return(facebook_data)
    allow(facebook_data).to receive(:call).and_return(facebook_data_result)
    allow(SetAccountProvider).to receive(:new).and_return(set_account_provider)
    allow(set_account_provider).to receive(:call)
    allow(facebook_data).to receive(:call).and_return(facebook_data_result)
    allow(params).to receive(:get).with(:access_token).and_return('token')
  end

  context 'when correct facebook data' do
    let(:account_repo) { double(AccountRepository) }
    let(:account) { double(Account, id: 1) }
    let(:result) { subject.call }

    before do
      allow(facebook_data_result).to receive(:successful?).and_return(true)
      allow(facebook_data_result).to receive(:email).and_return('some@email')
      allow(AccountRepository).to receive(:new).and_return(account_repo)
      allow(account_repo).to receive(:find_by_email).and_return(account)
    end

    it 'finds account_by email' do
      result
      expect(account_repo).to have_received(:find_by_email).with('some@email')
    end

    context 'when new account' do
      before do
        allow(account_repo).to receive(:find_by_email).and_return(nil)
        allow(account_repo).to receive(:create).and_return(account)
        result
      end

      it 'creates new account' do
        expect(account_repo).to have_received(:create)
      end
    end

    it 'updates account provider' do
      result
      expect(set_account_provider).to have_received(:call)
    end

    it 'returns success result' do
      expect(result.successful?).to be true
    end

    it 'returns jwt token' do
      expect(result.token).to match(JWT_PATTERN)
    end
  end

  context 'when incorrect facebook data' do
    before do
      allow(facebook_data_result).to receive(:successful?).and_return(false)
      allow(facebook_data_result).to receive(:error).and_return('Error')
      @result = subject.call
    end

    it 'returns fail result' do
      expect(@result.successful?).to be false
    end

    it 'returns error message' do
      expect(@result.error).to eq 'Error'
    end
  end

  context 'when missing access token' do
    let(:params_status) { false }

    before do
      @result = subject.call
    end

    it 'returns failing result' do
      expect(@result.successful?).to be false
    end

    it 'returns error message' do
      expect(@result.error).to eq 'Missing access token.'
    end
  end
end
