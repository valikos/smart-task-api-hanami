module Api::Controllers::Tasks
  class Create
    include Api::Action

    expose :task

    params do
      required(:data).schema do
        required(:type).value(eql?: 'tasks')

        required(:relationships).schema do
          required(:project).schema do
            required(:data).schema do
              required(:type).value(eql?: 'projects')
              required(:id).filled(:int?)
            end
          end
        end

        required(:attributes).schema do
          required(:title).filled
        end
      end
    end

    def call(params)
      if params.valid?
        repository = TaskRepository.new
        project_id = params.get(:data, :relationships, :project, :data, :id)
        @task = repository.create params
                                    .get(:data, :attributes)
                                    .merge(project_id: project_id)
        self.status = 201
      else
        status 403, {}
      end
    end
  end
end
