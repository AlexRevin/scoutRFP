class TagSerializer < ActiveModel::Serializer
  attributes :id, :title

  belongs_to :task
end
