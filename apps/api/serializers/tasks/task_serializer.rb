class TaskSerializer < BaseSerializer
  attribute :title
  attribute :completed
  attribute :due_date

  has_one :project, include_data: true do
    ProjectRepository.new.find_by_task(self.object)
  end

  has_many :comments, include_data: true do
    CommentRepository.new.find_by_task(self.object)
  end
end
