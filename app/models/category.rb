class Category < ActiveRecord::Base
  # name field must be present, unique, and with min & max rules.
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # Validates whether the value of the specified attributes are unique across the system.
  # Useful for making sure that only one field can be named a certain way. In this case :name.
  validates_uniqueness_of :name
end
