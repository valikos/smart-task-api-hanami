require_relative '../../../../apps/oauth/controllers/facebook/token'

RSpec.describe OAuth::Controllers::Facebook::Token do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:facebook_login) do
    double('FacebookLogin', successful?: true)
  end

  before do
    allow(FacebookLogin).to receive(:new).and_return(facebook_login)
    allow(facebook_login).to receive(:call).and_return(facebook_login)
  end

  context 'when valid access token' do
    before do
      allow(facebook_login).to receive(:token).and_return('token')
    end

    it 'returns 200 status' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end

    it 'returns auth token in headers' do
      response = action.call(params)
      expect(response[1]['Authorization']).to eq 'token'
    end
  end

  context 'when invalid access token' do
    let(:facebook_login) do
      double('FacebookLogin', successful?: false, error: 'error')
    end

    it 'returns message with error' do
      response = action.call(params)
      expect(response[2].first).to eq 'error'
    end

    it 'returns 400 status' do
      response = action.call(params)
      expect(response[0]).to eq 400
    end
  end
end
