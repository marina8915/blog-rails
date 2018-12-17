class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true, presence: true
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password
  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/x,
            message: 'must contain a digit, a lower case and an upper case character.', if: :password

  before_save :change_data

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.reset_password(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  private

  def change_data
    self.email = self.email.downcase
  end
end
