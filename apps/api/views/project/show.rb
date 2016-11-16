module Api::Views::Project
  class Show
    include Api::View

    format :json

    def render
      raw JSON.generate(ProjectSerializer.serialize(project))
    end
  end
end
