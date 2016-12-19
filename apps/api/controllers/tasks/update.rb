require_relative '../../middlewares/snake_case_attributes'

module Api::Controllers::Tasks
  class Update
    include Api::Action

    use ::SnakeCaseAttributes

    expose :task

    params do
      required(:data).schema do
        required(:type).value(eql?: 'tasks')
        required(:id).filled(:int?)

        required(:attributes).schema do
          optional(:title).filled
          optional(:completed).filled
          optional(:due_date).filled
        end
      end
    end

    def call(params)
      if params.valid?
        repository = TaskRepository.new
        @task = repository.update(
          params.get(:data, :id),
          params.get(:data, :attributes)
        )
      else
        status 403, {}
      end
    end
  end
end
