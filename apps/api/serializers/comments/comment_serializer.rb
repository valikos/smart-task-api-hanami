class CommentSerializer < BaseSerializer
  attribute :body
  attribute :created_at

  has_one :task do
    TaskRepository.new.find(self.object.task_id)
  end
end
