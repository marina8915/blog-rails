class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :rating, inclusion: 1..5, presence: true
end
