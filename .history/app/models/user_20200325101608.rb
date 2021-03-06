class User < ActiveRecord::Base

  # In the database a User has_many articles
  has_many :articles

  # Before the User is saved set the email to downcase.
  before_save { self.email = email.downcase }

  # Add a validation for the username. Make sure one is present, unique to all other usernames without taking case into account and set a length rule.
  validates :username, presence: true, uniqueness: { case_sensitive: false }, # Turning off case sensitivity rails will ingnore case and treat lowercase and uppercase the same.
            length: { minimum: 3, maximum: 25 }

  # Using REGEX make sure the email is formated correctly.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Add a validation for the email. That it is present, has a length rule, and is unique to all other emails without taking case into account and then making sure it is correctly formated.
  validates :email, presence: true, length: { maximum: 105 }, 
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX } # VALID_EMAIL_REGEX checks for a valid email pattern.

# Adds methods to set and authenticate against a BCrypt password. This mechanism requires you to have a XXX_digest attribute. Where XXX is the attribute name of your desired password.
# The following validations are added automatically:
# Password must be present on creation
# Password length should be less than or equal to 72 bytes
# Confirmation of password (using a XXX_confirmation attribute)
  has_secure_password
  
end