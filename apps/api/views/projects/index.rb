module Api::Views::Projects
  class Index
    include Api::View

    format :json

    def render
      raw JSON.generate(
        ProjectSerializer.serialize(
          projects, is_collection: true, include: 'tasks'
        )
      )
    end
  end
end
