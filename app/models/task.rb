class Task < ApplicationRecord
  # validations
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :effort_per_day_in_hours, presence: true

  # relations
  belongs_to :client
  belongs_to :project

  # hooks
  before_validation :set_client, if: 'project.present?'

  private
  def set_client
    self.client_id = project.client_id
  end

end
