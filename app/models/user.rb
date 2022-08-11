class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'
  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def three_recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
