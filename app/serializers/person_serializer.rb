class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :job_title
end
