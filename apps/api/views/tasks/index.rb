module Api::Views::Tasks
  class Index
    include Api::View

    format :json

    def render
      raw JSON.generate(TaskSerializer.serialize(tasks, is_collection: true))
    end
  end
end
