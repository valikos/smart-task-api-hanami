module Api::Controllers::Tasks
  class Update
    include Api::Action

    expose :task

    params do
      required(:data).schema do
        required(:type).value(eql?: 'tasks')
        required(:id).filled(:int?)

        required(:attributes).schema do
          optional(:title).filled
          optional(:completed).filled
        end

        required(:relationships).schema do
          required(:project).schema do
            required(:data).schema do
              required(:type).value(eql?: 'projects')
              required(:id).filled(:int?)
            end
          end
        end
      end
    end

    def call(params)
      if params.valid?
        project_id = params.get(:data, :relationships, :project, :data, :id)
        repository = TaskRepository.new
        update_data = params.get(:data, :attributes)
                        .merge(project_id: project_id)
        @task = repository.update(params.get(:data, :id), update_data)
      else
        status 403, {}
      end
    end
  end
end
