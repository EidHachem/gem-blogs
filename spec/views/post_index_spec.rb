require 'rails_helper'
RSpec.describe 'posts#posts', type: :system do
  before do
    driven_by(:rack_test)
  end
  it 'I can see the user\'s profile picture' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    visit "/user/#{user.id}/post/"
    expect(page).to have_css("img[src*='photo.jpg']")
  end
  it 'I can see the user\'s username' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content(user.name)
  end
  it 'I can see the number of posts the user has written' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content("Number of posts: #{user.post_counter}")
  end
  it 'I can see a post\'s title' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/"
    expect(page).to have_content(post.title)
  end
  it 'I can see some of the post\'s body' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/"
    expect(page).to have_content(post.text)
  end
  it 'I can see the first comments on a post' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    Comment.create(author: user, post:, text: 'First comment')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content('First comment')
  end
  it 'I can see how many comments a post has' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    Comment.create(author: user, post:, text: 'First comment')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end
  it 'I can see how many likes a post has' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    Comment.create(author: user, post:, text: 'First comment')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
  it 'I can see a section for pagination if there are more posts than fit on the view' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    visit "/user/#{user.id}/post/"
    expect(page).to have_content('Pagination')
  end
  it 'When I click on a post, it redirects me to that post\'s show page' do
    user = User.create(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
    visit "/user/#{user.id}/post/"
    click_on post.title
    expect(page).to have_current_path("/user/#{user.id}/post/#{post.id}")
  end
end
