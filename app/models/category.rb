class Category < ActiveRecord::Base
  validates :name, length: { maximum: 20 }, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :sidebar, length: { maximum: 500 }
  validates :submission_text, length: { maximum: 1024 }

  has_many :posts
  default_scope { order('lower(name)') }
end
