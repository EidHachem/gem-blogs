class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: :post_counter
  has_many :likes
  has_many :comments

  def five_recent_comments
    comments.order(created_at: :desc).limit(50)
  end

  def update_posts_counter
    author.increment!(:post_counter)
  end
end
