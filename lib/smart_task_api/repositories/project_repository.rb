class ProjectRepository < Hanami::Repository

  associations do
    has_many :tasks
  end

  def get_tasks(project)
    assoc(:tasks, project)
  end

  def find_with_tasks(id)
    aggregate(:tasks).where(project_id: id).as(Project).one
  end

  def add_task(project, data)
    assoc(:tasks, project).add(data)
  end

  def count
    DB[:projects].count
  end

  def find_by_user(id, account)
    projects
      .where(id: id, account_id: account.id)
      .as(Project)
      .first
  end

  def all_by_account(account)
    projects
      .where(account_id: account.id)
      .as(Project).to_a
  end
end
