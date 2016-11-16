module Api::Controllers::Project
  class Destroy
    include Api::Action

    def call(params)
      entity = ProjectRepository.find(params[:id])
      ProjectRepository.delete(entity)
      status 200, "Your resource has been deleted"
    end
  end
end
