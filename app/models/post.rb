class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  def update_counter
    author.update(post_counter: author.posts.count)
  end

  def five_recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end
end
