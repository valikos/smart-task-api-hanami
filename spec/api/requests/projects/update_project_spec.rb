require 'spec_helper'

describe 'Api', type: :request do
  describe 'Update Project' do
    def app
      @app ||= Hanami.app
    end

    before do
      @token = create_account
      @current_user = AccountRepository.new.last
      @project = create_project(title: 'Testing', account_id: @current_user.id)
    end

    let(:repo) { ProjectRepository.new }

    let(:params) do
      {
        'data': {
          type: 'projects',
          id: @project.id,
          attributes: { title: 'Updated' }
        }
      }
    end

    context 'when valid params' do
      before do
        xhr_patch("/api/projects/#{@project.id}", params, @token)
      end

      xit 'creates new project' do
        expect{ repo.first.title }.to be('Updated')
      end
    end
  end
end
