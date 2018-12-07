class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates_presence_of :commenter, :body
  validates_presence_of :user, :message => 'exist, you can not use this name.'
end
