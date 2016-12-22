module Api::Views::Projects
  class Show
    include Api::View

    format :json

    def render
      raw JSON.generate(ProjectSerializer.serialize(project, include: 'tasks'))
    end
  end
end
