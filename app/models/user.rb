class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true, presence: true
  validates :name, presence: true, uniqueness: true
end
