Hanami::Model.migration do
  up do
    add_column :tasks, :due_date, Date
  end

  down do
    drop_column :tasks, :due_date
  end
end
