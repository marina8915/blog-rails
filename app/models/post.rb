class Post < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  validates_presence_of :user_id
  validates_size_of :description, maximum: 1000

  mount_uploader :img, ImageUploader

  before_save :change_data

  def to_param
    [id, title.parameterize].join("-")
  end

  private

  def change_data
    self.title = self.title.capitalize
  end
end
