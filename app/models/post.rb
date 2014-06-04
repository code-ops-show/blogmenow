class Post < ActiveRecord::Base
  include Analytix::Model
  enum status: [:draft, :published]

  validates :title, presence: true
  has_many :comments
end
