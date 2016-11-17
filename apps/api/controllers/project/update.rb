module Api::Controllers::Project
  class Update
    include Api::Action

    expose :project

    params do
      required(:title).filled(max_size?: 140)
    end

    def call(params)
      if params.valid?
        repository = ProjectRepository.new
        project = repository.find_by_user(params[:id], current_user)
        return status(404, {}) unless project
        project = repository.update(project.id, title: params[:title])
        status 200, {}
      else
        status 403, {}
      end
    end
  end
end
