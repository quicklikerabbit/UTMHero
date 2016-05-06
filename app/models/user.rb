class User < ActiveRecord::Base

  has_many :clients
  has_many :links
  has_many :client_users

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password,
  length: { in: 6..20 }, on: :create


end
