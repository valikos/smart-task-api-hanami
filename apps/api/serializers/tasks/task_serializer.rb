class TaskSerializer < BaseSerializer
  attribute :title
  attribute :completed

  has_one :project do
    ProjectRepository.new.find_by_task(self.object)
  end

  has_many :comments do
    CommentRepository.new.find_by_task(self.object)
  end
end
