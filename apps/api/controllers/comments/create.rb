module Api::Controllers::Comments
  class Create
    include Api::Action

    expose :comment

    params do
      required(:data).schema do
        required(:type).value(eql?: 'comments')

        required(:relationships).schema do
          required(:task).schema do
            required(:data).schema do
              required(:type).value(eql?: 'tasks')
              required(:id).filled(:int?)
            end
          end
        end

        required(:attributes).schema do
          required(:body).filled
        end
      end
    end

    def call(params)
      if params.valid?
        repository = TaskRepository.new

        task = repository.find(
          params.get(:data, :relationships, :task, :data, :id)
        )

        comment = repository.add_comment(task, params.get(:data, :attributes))

        @comment = Comment.new(comment.to_hash)

        self.status = 201
      else
        status 403, {}
      end
    end
  end
end
