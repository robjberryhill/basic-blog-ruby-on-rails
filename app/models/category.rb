class Category < ActiveRecord::Base
  # We want a category to have many articles. We need to do this through an association from another table.
  # A category has_many article_categories
  has_many :article_categories
  # A category has_many articles through the article_categories model/table association.
  has_many :articles, through: :article_categories
  # name field must be present, unique, and with min & max rules.
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # Validates whether the value of the specified attributes are unique across the system.
  # Useful for making sure that only one field can be named a certain way. In this case :name.
  validates_uniqueness_of :name
end
