module Api::Views::Project
  class Update
    include Api::View

    format :json

    def render
      raw JSON.generate(ProjectSerializer.serialize(project))
    end
  end
end
