class Task < Hanami::Entity
  attributes do
    attribute :id,          Types::Int
    attribute :project_id,  Types::Int
    attribute :title,       Types::String
    attribute :completed,   Types::Bool
    attribute :due_date,    Types::Date

    attribute :created_at,  Types::Time
    attribute :updated_at,  Types::Time
  end
end
