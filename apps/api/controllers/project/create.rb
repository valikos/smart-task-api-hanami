module Api::Controllers::Project
  class Create
    include Api::Action

    expose :project

    params do
      required(:title).filled(max_size?: 140)
    end

    def call(params)
      if params.valid?
        repository = ProjectRepository.new
        @project = repository.create(params.to_h.merge(account_id: account_id))
        self.status = 201
      else
        status 403, {}
      end
    end
  end
end
