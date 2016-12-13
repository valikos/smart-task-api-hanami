module Api::Controllers::Projects
  class Index
    include Api::Action

    expose :projects

    def call(params)
      repository = ProjectRepository.new
      @projects = repository.all_by_account_with_tasks(current_user)
    end
  end
end
