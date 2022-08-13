class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  validates :title, presence: true, length: { in: 1..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_counter

  def five_recent_comments
    comments.includes(:post).order(created_at: :desc).limit(5)
  end

  private

  def update_counter
    author.increment!(:post_counter)
  end
end
