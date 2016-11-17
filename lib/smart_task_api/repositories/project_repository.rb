class ProjectRepository < Hanami::Repository
  def count
    DB[:projects].count
  end

  def find_by_user(id, account)
    projects
      .where(id: id, account_id: account.id, id: id)
      .as(Project)
      .first
  end

  def all_by_account(account)
    projects
      .where(account_id: account.id)
      .as(Project)
  end
end
