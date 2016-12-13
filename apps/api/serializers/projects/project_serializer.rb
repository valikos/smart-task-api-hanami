class ProjectSerializer < BaseSerializer
  attribute :title

  has_many :tasks
end
