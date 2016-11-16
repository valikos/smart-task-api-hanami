class ProjectRepository
  include Hanami::Repository

  def self.count
    fetch('select count(*) from projects').first.fetch(:count)
  end

  def self.all_by_account(account)
    query do
      where(account_id: account.id)
    end
  end
end
