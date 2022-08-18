class Like < ApplicationRecord
  belongs_to :post, counter_cache: :likes_counter
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
