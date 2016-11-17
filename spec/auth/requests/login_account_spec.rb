require 'spec_helper'

describe 'Auth' do
  describe 'Login Account' do
    include Rack::Test::Methods

    def app
      @app ||= Hanami.app
    end

    let(:create_account_params) do
      { 'login':            'test@email.com',
        'login-confirm':    'test@email.com',
        'password':         'password',
        'password-confirm': 'password' }
    end

    before do
      create_account_query = Rack::Utils.build_query(create_account_params)
      login_query = Rack::Utils.build_query(login_params)

      post "/auth/create-account?#{create_account_query}", {}, { "CONTENT_TYPE" => "application/json" }
      post "/auth/login?#{login_query}", {}, { "CONTENT_TYPE" => "application/json" }
    end

    context 'when correct credentials' do

      let(:login_params) do
        { 'login':            'test@email.com',
          'password':         'password' }
      end

      it 'returns 200 status' do
        expect(last_response.ok?).to be_truthy
      end

      it 'returns authorization token' do
        expect(last_response.header['Authorization']).to be_truthy
      end
    end

    context 'when wrong credentials' do
      let(:login_params) do
        { 'login':            'wrong@email.com',
          'password':         'password' }
      end

      it 'returns bad request status' do
        expect(last_response.bad_request?).to be_truthy
      end

      it 'returns errors in body' do
        expect(last_response.body).to match(/error/)
      end
    end
  end
end
