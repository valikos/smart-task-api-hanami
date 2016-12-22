module Api::Views::Projects
  class Index
    include Api::View

    format :json

    def render
      raw JSON.generate(
        ProjectSerializer.serialize(
          projects,
          is_collection: true,
          include: [
            'tasks',
            'tasks.project',
            'tasks.comments',
            'tasks.comments.task'
          ]
        )
      )
    end
  end
end
