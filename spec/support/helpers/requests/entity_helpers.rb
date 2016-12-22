module EntityHelpers
  def create_project(params)
    repo = ProjectRepository.new
    repo.create(params)
  end
end
