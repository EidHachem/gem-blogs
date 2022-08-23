require 'rails_helper'
RSpec.describe 'post#post', type: :system do
  before do
    driven_by(:rack_test)
  end
  it 'I can see the post\'s title' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content(post.title)
  end
  it 'I can see who wrote the post' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content(user.name)
  end
  it 'I can see how many comments it has' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content("comments: #{post.comments_counter}")
  end
  it 'I can see how many likes it has' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    Like.create(post:, author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content("likes: #{post.likes_counter}")
  end
  it 'I can see the post body' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    Like.create(post:, author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content(post.text)
  end
  it 'I can see the username of each commentor' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    comment = Comment.create(author: user, post:, text: 'First comment')
    Like.create(post:, author: user)
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content(comment.author.name)
  end
  it 'I can see the comment each commentor left' do
    user = User.create(name: 'Evren', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    user2 = User.create(name: 'Eid', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    comment = Comment.create(author: user, post:, text: 'First comment')
    comment2 = Comment.create(author: user2, post:, text: 'Second comment')
    visit "/user/#{user.id}/post/#{post.id}"
    expect(page).to have_content(comment.text)
    expect(page).to have_content(comment2.text)
  end
end
