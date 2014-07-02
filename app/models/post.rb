class Post < ActiveRecord::Base
  include Analytix::Model

  enum status: [:draft, :published]
  # enum status: { published: 1, draft: 0 }

  validates :title, presence: true
  has_many :comments

  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :category

  scope :with_tags_and_count, -> { select([arel_table[Arel.star], Post.array_of_tags_hstore]) }
 
  class << self
    def array_of_tags_hstore
      Arel::Nodes::NamedFunction.new("ARRAY", [tags_hstore]).as("tags_with_count")
    end
 
    def tags_hstore
      Tag.arel_table.project(Arel.sql('hstore(tag)')).from(tags_from_taggings)
    end
 
    def tags_from_taggings
      Tag.joins(:taggings)
           .select(Tag.arel_table[:name], Tag.arel_table[:posts_count])
             .from(tags_with_posts_count)
               .where(Tagging.arel_table[:post_id].eq(arel_table[:id])).as('tag')
    end
 
    def tags_with_posts_count
      Tag.joins(:posts)
           .select(Tag.arel_table[Arel.star], Arel::Nodes::NamedFunction.new("COUNT", [arel_table[:id]])
             .as('posts_count')).group(Tag.arel_table[:id]).as('tags')
    end
  end
end
