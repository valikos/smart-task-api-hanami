class TaskSerializer < BaseSerializer
  attribute :title
  attribute :completed
  attribute :due_date

  has_one :project, include_data: true do
    ProjectRepository.new.find(self.object.project_id)
  end
end
