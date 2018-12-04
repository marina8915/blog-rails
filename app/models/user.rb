class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true, presence: true
  validates :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/x }

  before_save :change_data

  private

  def change_data
    self.email = self.email.downcase
    self.name = self.name.capitalize
  end
end
