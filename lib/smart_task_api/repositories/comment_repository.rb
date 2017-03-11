class CommentRepository < Hanami::Repository

  def count
    comments.count
  end

  def find_by_task(task)
    comments.where(task_id: task.id).as(Comment).to_a
  end
end
