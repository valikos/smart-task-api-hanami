module EntityHelpers
  def create_project(params)
    repo = ProjectRepository.new
    repo.create(params)
  end

  def create_task(params)
    repo = TaskRepository.new
    repo.create(params)
  end

  def create_comment(params)
    repo = CommentRepository.new
    repo.create(params)
  end
end
