module Api::Views::Tasks
  class Create
    include Api::View

    format :json

    def render
      raw JSON.generate(TaskSerializer.serialize(task))
    end
  end
end
