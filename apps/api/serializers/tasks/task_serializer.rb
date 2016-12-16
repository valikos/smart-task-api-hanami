class TaskSerializer < BaseSerializer
  attribute :title
  attribute :completed
  attribute :due_date

  has_one :project do
    ProjectRepository.new.find_by_task(self.object)
  end

  has_many :comments do
    CommentRepository.new.find_by_task(self.object)
  end
end
