class CommentSerializer < BaseSerializer
  attribute :body
  attribute :created_at

  has_one :task, include_data: true do
    TaskRepository.new.find(self.object.task_id)
  end
end
