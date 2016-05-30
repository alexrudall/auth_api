class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :groups

  validates :password, length: { minimum: 8 }, allow_nil: true
end
