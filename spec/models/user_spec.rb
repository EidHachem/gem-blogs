require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new

  it 'should not create user because name is not given' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'should not accecpt negative values for post counter' do
    user.post_counter = -2
    expect(user).to_not be_valid
  end
  it 'tests recent method' do
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
    Post.create(author: user, title: 'Hello', text: 'This is my first post')
    expect(user.three_recent_posts).to eq(user.posts.last(3))
  end
end
