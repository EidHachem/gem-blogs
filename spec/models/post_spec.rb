require 'rails_helper'

RSpec.describe User, type: :model do
  post = Post.new

  it 'should not create post because title is not given' do
    post.title = nil
    expect(post).to_not be_valid
  end
  it 'should not accecpt a values for title over 250 chars' do
    post.title = 'A very long title' * 20
    expect(post).to_not be_valid
  end
  it 'should not accecpt negative values for comments counter' do
    post.comments_counter = -3
    expect(post).to_not be_valid
  end
  it 'should not accecpt negative values for likes counter' do
    post.likes_counter = -20
    expect(post).to_not be_valid
  end
  it 'should return the last 5 recent comments' do
    first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post2 = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')

    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    Comment.create(post: post2, author: first_user, text: 'Hi Tom!', post_id: 9)
    expect(post2.five_recent_comments).to eq(post2.comments.last(5))
  end
end
