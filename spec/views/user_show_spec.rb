require 'rails_helper'

RSpec.describe 'Testing users views', type: :feature do
  describe 'user#show views' do
    before(:each) do
      first_user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      (1..5).each { |i| first_user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
      visit "/user/#{first_user.id}"
    end
    it "I can see the user's profile picture" do
      expect(page.find('img')['src']).to have_content 'photo.jpg'
    end
    it 'I can see the user\'s username' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      visit "/user/#{user.id}"
      expect(page).to have_content 'Tom'
    end
    it 'I can see the number of posts the user has written' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      visit "/user/#{user.id}"
      expect(page).to have_content 'Number of posts: 0'
    end
    it 'I can see the user\'s bio' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      visit "/user/#{user.id}"
      expect(page).to have_content 'Teacher from Mexico.'
    end
    it 'I can see the user\'s first 3 posts' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      Post.create(title: 'Hello', text: 'This is my first post', author: user)
      Post.create(title: 'Hello2', text: 'This is my second post', author: user)
      Post.create(title: 'Hello3', text: 'This is my first post', author: user)
      Post.create(title: 'Hello4', text: 'This is my second post', author: user)
      visit "/user/#{user.id}"
      last_three_posts = user.three_recent_posts
      expect(page).to have_content(last_three_posts[0].title)
      expect(page).to have_content(last_three_posts[1].title)
      expect(page).to have_content(last_three_posts[2].title)
    end
    it 'I can see a button that lets me view all of a user\'s posts' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      visit "/user/#{user.id}"
      click_on 'See all posts'
      expect(page).to have_current_path("/user/#{user.id}/post/")
    end
    it 'When I click a user\'s post, it redirects me to that post\'s show page' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      post = Post.create(title: 'Hello', text: 'This is my first post', author: user)
      visit "/user/#{user.id}"
      click_on post.title
      expect(page).to have_current_path("/user/#{user.id}/post/#{post.id}")
    end
    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
      user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
      visit "/user/#{user.id}"
      click_on 'See all posts'
      expect(page).to have_current_path("/user/#{user.id}/post/")
    end
  end
end
