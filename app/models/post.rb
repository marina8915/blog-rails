class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates_presence_of :user_id
  before_save :change_data

  private

  def change_data
    self.title = self.title.capitalize
  end
end
