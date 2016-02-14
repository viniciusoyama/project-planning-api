class Project < ApplicationRecord
  # validations
  validates :name, presence: true

  # relations
  belongs_to :client
end
