class Comment < ApplicationRecord
  has_ancestry orphan_strategy: :rootify

  belongs_to :post
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  validates_presence_of :commenter, :body
end
