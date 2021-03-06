module Api::Controllers::Projects
  class Destroy
    include Api::Action

    def call(params)
      repository = ProjectRepository.new
      project = repository.find_by_account(params[:id], current_user)

      if project
        repository.delete(project.id)
        halt 204
      else
        status 404, ''
      end
    end
  end
end
