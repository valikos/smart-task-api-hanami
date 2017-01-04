Hanami::Model.migration do
  up do
    create_table(:account_providers) do
      foreign_key :id, :accounts, primary_key: true, type: :Bignum

      column :provider,     String, null: false
      column :access_token, String, null: false
    end
  end

  down do
    drop_table(:account_providers)
  end
end
