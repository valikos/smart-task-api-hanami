require 'spec_helper'

describe 'Api', type: :request do
  describe 'Destroy Project' do
    def app
      @app ||= Hanami.app
    end

    let(:repository) { ProjectRepository.new }

    before do
      @auth_token = create_account
      @current_user = AccountRepository.new.last
      @project = create_project(title: 'Testing', account_id: @current_user.id)
    end

    context 'when valid params' do
      it 'deletes project' do
        expect{
          xhr_delete("/api/projects/#{@project.id}", @auth_token)
        }.to change{repository.count}.from(1).to(0)
      end
    end
  end
end
