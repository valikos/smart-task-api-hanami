module Api::Controllers::Project
  class Create
    include Api::Action

    expose :project

    params do
      required(:title).filled(max_size?: 140)
    end

    def call(params)
      if params.valid?
        self.status = 201
        entity = Project.new(params.to_h.merge(account_id: account_id))
        @project = ProjectRepository.create(entity)
      else
        self.status = 403
      end
    end
  end
end
