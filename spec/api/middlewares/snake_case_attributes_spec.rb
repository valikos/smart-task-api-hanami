require 'spec_helper'

describe SnakeCaseAttributes do
  let(:app) { ->(env) { [200, env, 'app'] } }
  let(:middleware) do
    SnakeCaseAttributes.new(app)
  end
  let(:request) { Rack::MockRequest.new }

  context 'when router params is passed' do
    let(:opts) { Hash.new }

    let(:attributes) do
      {
        data: {
          attributes: {
            title:      'testing',
            'due-date': '1111-11-11'
          }
        }
      }
    end

    let(:expected) {
      {
        data: {
          attributes: {
            title:    'testing',
            due_date: '1111-11-11'
          }
        }
      }
    }

    before do
      opts['router.params'] = attributes
      @env = Rack::MockRequest.env_for('', opts)
    end

    it 'parse attributes' do
      res = middleware.call(@env)
      expect(res[1]['router.params']).to eq expected
    end
  end

  context 'when router params is missed' do
    before do
      @env = Rack::MockRequest.env_for('')
    end

    it 'returns original env' do
      res = middleware.call(@env)
      expect(res[1]).to eq @env
    end
  end
end
