Hanami::Model.migration do
  up do
    create_table :projects do
      primary_key :id
      foreign_key :account_id, :accounts, on_delete: :cascade, null: false

      column :title,       String, null: false, size: 140
      column :description, String
      column :created_at,  DateTime, null: false
      column :updated_at,  DateTime, null: false
    end
  end

  down do
    drop_table :projects
  end
end
