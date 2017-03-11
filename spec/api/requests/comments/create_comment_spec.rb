require 'spec_helper'

describe 'Api', type: :request do
  describe 'Create Comment' do
    def app
      @app ||= Hanami.app
    end

    let(:repository) { CommentRepository.new }

    let(:params) do
      {
        data: {
          type: 'comments',
          attributes: { body: 'Lorem' },
          relationships: {
            task: {
              data: { type: 'tasks', id: @task.id }
            }
          }
        }
      }
    end

    before do
      @auth_token = create_account
      @current_user = AccountRepository.new.last
      @project = create_project(title: 'Testing', account_id: @current_user.id)
      @task = create_task(title: 'Foo', project_id: @project.id)
    end

    context 'when valid params' do
      it 'creates new comment for a task' do
        expect{
          xhr_post('/api/comments', params, @auth_token)
        }.to change{repository.count}.from(0).to(1)
      end
    end
  end
end
