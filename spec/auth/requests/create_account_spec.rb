require 'spec_helper'

describe 'Auth' do
  describe 'Create Account' do
    include Rack::Test::Methods

    def app
      @app ||= Hanami::Container.new
    end

    before do
      query_string = Rack::Utils.build_query(login_params)
      post "/auth/create-account?#{query_string}", {}, { "CONTENT_TYPE" => "application/json" }
    end

    context 'when correct parameters' do
      let(:login_params) do
        { 'login':            'test@email.com',
          'login-confirm':    'test@email.com',
          'password':         'password',
          'password-confirm': 'password' }
      end

      it 'returns 200 status' do
        expect(last_response.ok?).to be_truthy
      end

      it 'returns authorization token' do
        expect(last_response.header['Authorization']).to be_truthy
      end
    end

    context 'when missing parameters' do
      let(:login_params) do
        { 'login':            'test@email.com',
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
