module Api::Controllers::Project
  class Show
    include Api::Action

    expose :project

    def call(params)
      @project = ProjectRepository.find(params[:id])
    end
  end
end
