class ProjectRepository < Hanami::Repository

  associations do
    has_many :tasks
  end

  def get_tasks(project)
    assoc(:tasks, project).to_a
  end

  def find_with_tasks(id)
    aggregate(:tasks).where(projects__id: id).as(Project).one
  end

  def add_task(project, data)
    assoc(:tasks, project).add(data)
  end

  def count
    DB[:projects].count
  end

  def find_by_account(id, account)
    projects.where(id: id, account_id: account.id).as(Project).one
  end

  def find_by_account_with_tasks(id, account)
    aggregate(:tasks).where(id: id, account_id: account.id).as(Project).one
  end

  def all_by_account(account)
    projects
      .where(account_id: account.id)
      .as(Project).to_a
  end

  def all_by_account_with_tasks(account)
    aggregate(:tasks).where(account_id: account.id).as(Project).to_a
  end
end
