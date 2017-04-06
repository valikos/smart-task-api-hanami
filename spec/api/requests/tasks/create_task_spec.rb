require 'spec_helper'

describe 'Api', type: :request do
  describe 'Create Task' do
    def app
      @app ||= Hanami.app
    end

    let(:repository) { TaskRepository.new }

    let(:params) do
      {
        'data': {
          type: 'tasks',
          attributes: { title: 'Todo' },
          relationships: {
            project: {
              data: { type: 'projects', id: @project.id }
            }
          }
        }
      }
    end

    before do
      @auth_token = create_account
      @current_user = AccountRepository.new.last
      @project = create_project(title: 'Testing', account_id: @current_user.id)
    end

    context 'when valid params' do
      it 'creates new task for a project' do
        expect{
          xhr_post('/api/tasks', params, @auth_token)
        }.to change{repository.count}.from(0).to(1)
      end
    end
  end
end
