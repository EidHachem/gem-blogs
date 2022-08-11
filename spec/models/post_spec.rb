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
end
