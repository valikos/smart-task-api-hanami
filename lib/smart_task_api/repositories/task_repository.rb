class TaskRepository < Hanami::Repository

  associations do
    has_many :comments
  end

  def count
    tasks.count
  end

  # def get_comments(task)
  #   aggregate(:comments, task).as(Comment).to_a
  # end

  def add_comment(task, data)
    assoc(:comments, task).add(data)
  end
end
