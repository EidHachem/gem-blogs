require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should not create comment without text' do
    comment = Comment.create(post_id: 8, author_id: 3, text: nil)
    expect(comment).to_not be_valid
  end
end
