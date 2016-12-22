class ProjectSerializer < BaseSerializer
  attribute :title

  has_many :tasks do
    ProjectRepository.new.get_tasks(self.object)
  end
end
