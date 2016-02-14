class Client < ApplicationRecord
  # validations
  validates :name, presence: true

  # relations
  has_many :projects
end
