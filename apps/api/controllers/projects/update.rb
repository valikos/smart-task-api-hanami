module Api::Controllers::Projects
  class Update
    include Api::Action

    expose :project

    params do
      required(:data).schema do
        required(:type).value(eql?: 'projects')
        required(:id).filled(:int?)

        required(:attributes).schema do
          required(:title).filled(max_size?: 140)
          optional(:description).filled(:str?)
        end
      end
    end

    def call(params)
      if params.valid?
        repository = ProjectRepository.new
        project = repository.find_by_account(params.get(:data, :id), current_user)
        return status(404, {}) unless project
        @project = repository.update(project.id, params.get(:data, :attributes))
        status 200, {}
      else
        status 403, {}
      end
    end
  end
end
