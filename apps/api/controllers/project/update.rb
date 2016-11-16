module Api::Controllers::Project
  class Update
    include Api::Action

    expose :project

    params do
      required(:title).filled(max_size?: 140)
    end

    def call(params)
      if params.valid?
        project = ProjectRepository.find(params[:id])
        project.update(title: params[:title])
        ProjectRepository.update(project)
        status 200, 'Ok'
      else
        status 403, 'Forbidden'
      end
    end
  end
end
