class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.pager(page)
    paginate(page: page, per_page: 5).order('id DESC')
  end

  def self.search(search)
    Post.where('title LIKE :search OR body LIKE :search OR description LIKE :search',
               search: "%#{search}%")
  end
end
