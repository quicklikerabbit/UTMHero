class Client < ActiveRecord::Base
  belongs_to :user
  has_many :links
  has_many :client_users
end
