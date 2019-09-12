class School < ApplicationRecord
  # Validations
  validates_presence_of :name, :address, :principal, :capacity, :private_school
  validates_uniqueness_of :name
  validates :capacity, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 52000}

  # Associations
  has_many :students, dependent: :destroy

end
