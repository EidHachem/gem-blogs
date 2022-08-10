class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment'
  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :likes, foreign_key: 'author_id', class_name: 'Like'

  def three_recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
