require 'rails_helper'

RSpec.describe 'Testing users views', type: :feature do
  describe 'user#index views' do
    before(:each) do
      User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
    end
    it 'I can see the username of all other users.' do
      visit '/'
      expect(page).to have_content 'Tom'
    end
    it 'I can see the number of posts each user has written.' do
      visit '/'
      expect(page).to have_content 'Number of posts: 0'
    end
    describe 'users#index views' do
      before(:each) do
        first_user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
        (1..5).each { |i| first_user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
        visit "/user/#{first_user.id}"
      end
      it 'I can see the profile pictures of each user.' do
        User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
        User.create!(name: 'Evren', photo: 'photo.jpg', bio: 'Teacher from Mexico.')
        expect(page.find('img')['src']).to have_content 'photo.jpg'
      end
      it 'should redirect to user\'s page' do
        user2 = User.create(name: 'Joe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
        visit '/'
        click_on user2.name
        expect(page).to have_current_path("/user/#{user2.id}/post/")
      end
    end
  end
end
