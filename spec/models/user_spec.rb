require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new
  user2 = User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

  it 'should not create user because name is not given' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'should not accecpt negative values for post counter' do
    user.post_counter = -2
    expect(user).to_not be_valid
  end
  it 'tests recent method' do
    Post.create(author: user2, title: 'Hello', text: 'This is my first post')
    Post.create(author: user2, title: 'Hello', text: 'This is my first post')
    Post.create(author: user2, title: 'Hello', text: 'This is my first post')
    Post.create(author: user2, title: 'Hello', text: 'This is my first post')
    expect(user2.three_recent_posts).to eq(user2.posts.last(3))
  end
end
