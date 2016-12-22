require 'rodauth/migrations'

Sequel.migration do
  up do
    create_table(:account_password_hashes) do
      foreign_key :id, :accounts, :primary_key=>true, :type=>:Bignum
      String :password_hash, :null=>false
    end
    Rodauth.create_database_authentication_functions(self)

    # Used by the disallow_password_reuse feature
    create_table(:account_previous_password_hashes) do
      primary_key :id, :type=>:Bignum
      foreign_key :account_id, :accounts, :type=>:Bignum
      String :password_hash, :null=>false
    end
    Rodauth.create_database_previous_password_check_functions(self)
  end

  down do
    Rodauth.drop_database_previous_password_check_functions(self)
    Rodauth.drop_database_authentication_functions(self)
    drop_table(:account_previous_password_hashes, :account_password_hashes)
  end
end
