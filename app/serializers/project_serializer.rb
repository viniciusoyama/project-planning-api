class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :client_id
end
