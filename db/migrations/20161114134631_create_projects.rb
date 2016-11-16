Hanami::Model.migration do
  up do
    create_table :projects do
      primary_key :id
      foreign_key :account_id, :accounts, on_delete: :cascade, null: false

      column :title, String, null: false, size: 140
    end
  end

  down do
    drop_table :projects
  end
end
