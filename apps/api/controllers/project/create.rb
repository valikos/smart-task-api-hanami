module Api::Controllers::Project
  class Create
    include Api::Action

    expose :project

    params do
      required(:data).schema do
        required(:type).value(eql?: 'projects')

        required(:attributes).schema do
          required(:title).filled(max_size?: 140)
        end
      end
    end

    def call(params)
      if params.valid?
        repository = ProjectRepository.new
        project_params = params.get(:data, :attributes).merge(account_id: account_id)
        @project = repository.create(project_params)
        self.status = 201
      else
        status 403, {}
      end
    end
  end
end
