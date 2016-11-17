module Api::Controllers::Project
  class Index
    include Api::Action

    expose :projects

    def call(params)
      repository = ProjectRepository.new
      @projects = repository.all_by_account(current_user)
    end
  end
end
