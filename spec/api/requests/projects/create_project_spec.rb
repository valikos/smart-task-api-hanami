require 'spec_helper'

describe 'Api', type: :request do
  describe 'Create Project' do

    let(:params) do
      { title: 'Testing' }
    end

    context 'when valid params' do
      it 'creates new project' do
        expect{
          xhr_post '/api/projects', params, create_account
        }.to change{ProjectRepository.count}.from(0).to(1)
      end
    end
  end
end
