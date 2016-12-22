module Api::Views::Tasks
  class Update
    include Api::View

    format :json

    def render
      raw JSON.generate(
        TaskSerializer.serialize(
          task,
          include: [
            'project',
            'comments'
          ]
        )
      )
    end
  end
end
