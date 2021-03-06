class Comment < Hanami::Entity
  attributes do
    attribute :id,          Types::Int
    attribute :task_id,     Types::Int
    attribute :body,        Types::String

    attribute :created_at,  Types::Time
    attribute :updated_at,  Types::Time
  end
end
