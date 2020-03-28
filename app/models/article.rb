class Article < ActiveRecord::Base
  # This record belongs_to only one user. The user has many articles.
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :user_id, presence: true
end
