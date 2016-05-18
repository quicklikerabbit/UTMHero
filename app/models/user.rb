class User < ActiveRecord::Base

  has_many :clients
  has_many :links
  has_many :client_users

  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true
  validate :available_email
  validate :valid_email
  validates :password,
  length: { in: 6..20 }, on: :create

  private

  def available_email
    if User.find_by(email: self.email)
      errors.add(:email, "is already associated with a user. Please use a different email or Log in.")
    end
  end

  VALID_EMAIL_REGEX = /@/

  def valid_email
    unless VALID_EMAIL_REGEX.match(self.email)
      errors.add(:email, "must be valid")
    end
  end
end
