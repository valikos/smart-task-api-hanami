Hanami::Model.migration do
  up do
    create_table :tasks do
      primary_key :id
      foreign_key :project_id, :projects, on_delete: :cascade, null: false

      column :title,      String, null: false, size: 140
      column :completed,  FalseClass, default: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :projects
  end
end
