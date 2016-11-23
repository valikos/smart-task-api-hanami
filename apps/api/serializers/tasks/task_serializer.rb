class TaskSerializer
  include JSONAPI::Serializer

  attribute :title
  attribute :completed
end
