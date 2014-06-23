class Post < ActiveRecord::Base
  include Analytix::Model

  enum status: [:draft, :published]
  # enum status: { published: 1, draft: 0 }

  validates :title, presence: true
  has_many :comments

  has_many :taggings
  has_many :tags, through: :taggings
end
