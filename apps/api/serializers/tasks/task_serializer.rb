class TaskSerializer < BaseSerializer
  attribute :title
  attribute :completed

  has_one :project, include_data: true do
    ProjectRepository.new.find(self.object.project_id)
  end
end
