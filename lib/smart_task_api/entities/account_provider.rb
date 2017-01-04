class AccountProvider < Hanami::Entity
  attributes do
    attribute :id,           Types::Int
    attribute :provider,     Types::String
    attribute :access_token, Types::String
  end
end
