class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates_presence_of :commenter, :body
  validates_presence_of :user, :message => 'exist, you can not use this name.'
end
