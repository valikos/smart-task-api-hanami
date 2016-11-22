class Project < Hanami::Entity
  attributes do
    attribute :id,          Types::Int
    attribute :account_id,  Types::Int
    attribute :title,       Types::String
    attribute :description, Types::String

    attribute :created_at,  Types::Time
    attribute :updated_at,  Types::Time
  end
end
