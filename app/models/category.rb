class Category < ActiveRecord::Base
  has_many :posts
  # has_many :photos

  scope :with_posts_count, -> { joins(:posts).select("categories.*, COUNT(posts.id) AS posts_count").group("categories.id") }

end
