class Article < ActiveRecord::Base
  # This record belongs_to only one user. The user has many articles.
  belongs_to :user
  # We want the article to have many categories. So we need to do this through an association.
  # A article has many article_categories model/table.
  has_many :article_categories
  # And a article has many categories through the article_categories model/table.
  # This allows us to have associations with another table through a table article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true
end
