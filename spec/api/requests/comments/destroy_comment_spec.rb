require 'spec_helper'

describe 'Api', type: :request do
  describe 'Destroy Comment' do
    def app
      @app ||= Hanami.app
    end

    let(:repository) { CommentRepository.new }

    before do
      @auth_token = create_account
      @current_user = AccountRepository.new.last
      @project = create_project(title: 'Testing', account_id: @current_user.id)
      @task = create_task(title: 'Foo', project_id: @project.id)
      @comment = create_comment(body: 'Lorem', task_id: @task.id)
    end

    context 'when valid params' do
      it 'deletes comment' do
        expect{
          xhr_delete("/api/comments/#{@comment.id}", @auth_token)
        }.to change{repository.count}.from(1).to(0)
      end
    end
  end
end
