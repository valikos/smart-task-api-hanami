module Api::Controllers::Projects
  class Show
    include Api::Action

    expose :project

    def call(params)
      repository = ProjectRepository.new
      @project = repository.find_by_user(params[:id], current_user)

      unless @project
        status 404, {}
      end
    end
  end
end
