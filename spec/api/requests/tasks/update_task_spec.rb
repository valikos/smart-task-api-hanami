require 'spec_helper'

describe 'Api', type: :request do
  describe 'Update Task' do
    def app
      @app ||= Hanami.app
    end

    let(:repository) { TaskRepository.new }

    let(:params) do
      {
        'data': {
          type: 'tasks',
          id: @task.id,
          attributes: {
            title: 'Bar',
            completed: true,
            'due-date': Date.today
          },
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
      @task = create_task(title: 'Foo', project_id: @project.id)
    end

    context 'when valid params' do
      it 'updates task title' do
        xhr_patch("/api/tasks/#{@task.id}", params, @auth_token)

        expect(repository.find(@task.id).title).to eq 'Bar'
      end

      it 'updates task due date' do
        xhr_patch("/api/tasks/#{@task.id}", params, @auth_token)

        expect(repository.find(@task.id).due_date).to eq Date.today
      end

      it 'updates task complete status' do
        xhr_patch("/api/tasks/#{@task.id}", params, @auth_token)

        expect(repository.find(@task.id).completed).to be_truthy
      end
    end
  end
end
