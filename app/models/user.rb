class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: { case_sensitive: false }, # Turning off case sensitivity rails will ingnore case and treat lowercase and uppercase the same.
            length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, 
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX } # VALID_EMAIL_REGEX checks for a valid email pattern.

end