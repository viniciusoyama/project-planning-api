class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :start_at, :end_at, :effort_per_day_in_hours
  attributes :client_id
  attributes :project_id
end
