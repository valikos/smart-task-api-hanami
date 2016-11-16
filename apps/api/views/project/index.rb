module Api::Views::Project
  class Index
    include Api::View

    format :json

    def render
      raw JSON.generate(ProjectSerializer.serialize(projects, is_collection: true))
    end
  end
end
