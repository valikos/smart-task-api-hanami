Hanami::Model.migration do
  up do
    create_table :comments do
      primary_key :id
      foreign_key :task_id, :tasks, on_delete: :cascade, null: false

      column :body,       String, null: false, size: 500
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :tasks
  end
end
