module Api::Controllers::Tasks
  class Index
    include Api::Action

    expose :tasks

    def call(params)
      repository = ProjectRepository.new
      project = repository.find params[:project_id]
      @tasks = repository.get_tasks(project)
    end
  end
end
