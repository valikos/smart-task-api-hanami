class ProjectSerializer < BaseSerializer
  attribute :title

  has_many :tasks, include_data: true do
    ProjectRepository.new.get_tasks(self.object)
  end
end
