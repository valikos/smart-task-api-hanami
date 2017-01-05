class AccountRepository < Hanami::Repository;

  def find_by_email(email)
    accounts.where(email: email).as(Account).one
  end
end
