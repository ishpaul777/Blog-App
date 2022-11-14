require 'rails_helper'

RSpec.describe User, type: :system do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    User.create(name: 'John', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    User.create(name: 'Jane', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    User.create(name: 'Jack', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    @post = Post.create(title: 'Hello', text: 'This is first post', author_id: @user.id)
    Post.create(title: 'Hello', text: 'This is Second post', author_id: @user.id)
    Post.create(title: 'Hello', text: 'This is Third post', author_id: @user.id)
  end

  describe 'users#index' do
    # I can see the user's name.
    it 'I can see the username of all other users.' do
      visit '/users'
      expect(page).to have_content('List of all users-')
      expect(page).to have_content('Lilly')
      expect(page).to have_content('John')
      expect(page).to have_content('Jane')
      expect(page).to have_content('Jack')
    end

    # I can see the profile picture for each user.
    it 'I can see the profile picture for each user.' do
      visit '/users'
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
    end

    # I can see the number of posts each user has written.
    it 'I can see the number of posts each user has written.' do
      visit '/users'
      expect(page).to have_content('Number of Posts- 1')
      expect(page).to have_content('Number of Posts- 0')
      expect(page).to have_content('Number of Posts- 0')
      expect(page).to have_content('Number of Posts- 0')
    end

    # When I click on a user, I am redirected to that user's show page.
    it 'When I click on a user, I am redirected to that user\'s show page.' do
      visit '/users'
      click_link 'Lilly'
      expect(page).to have_current_path("/users/#{@user.id}")
    end
  end

  describe 'users#show' do
    it 'I can see the user\'s page' do
      visit "/users/#{@user.id}"
      # I can see the user\'s username.
      expect(page).to have_content('Lilly')
      # I can see the user's profile picture.
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
      # I can see the user's bio.
      expect(page).to have_content('I am a student at Microverse')
      # I can see the user's first 3 posts.
      expect(page).to have_content('This is first post')
      expect(page).to have_content('This is Second post')
      expect(page).to have_content('This is Third post')
      # I can see a button that lets me view all of a user's posts.
      expect(page).to have_link('View all posts')
      # When I click a user's post, it redirects me to that post's show page.
      click_link 'This is first post'
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post.id}")
      # When I click to see all posts, it redirects me to the user's post's index page.
      click_link 'View all posts'
      expect(page).to have_current_path("/users/#{@user.id}/posts/")
    end
  end
end
