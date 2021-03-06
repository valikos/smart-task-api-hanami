module Api::Views::Projects
  class Create
    include Api::View

    format :json

    def render
      raw JSON.generate(ProjectSerializer.serialize(project))
    end
  end
end
