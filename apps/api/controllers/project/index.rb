module Api::Controllers::Project
  class Index
    include Api::Action

    expose :projects

    def call(params)
      @projects = ProjectRepository.all_by_account(current_user)
    end
  end
end
