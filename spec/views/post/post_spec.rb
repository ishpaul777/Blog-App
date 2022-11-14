require 'rails_helper'

RSpec.describe User, type: :system do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    @second_user = User.create(name: 'John', photo: 'https://i.imgur.com/1J3wQYt.jpg',
                               bio: 'I am a student at Microverse')
    User.create(name: 'Jane', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    User.create(name: 'Jack', photo: 'https://i.imgur.com/1J3wQYt.jpg', bio: 'I am a student at Microverse')
    @post = Post.create(title: 'Hello', text: 'This is first post', author_id: @user.id)
    @comment = Comment.create(text: 'This is first comment', author_id: @second_user.id, post_id: @post.id)
    Post.create(title: 'Hello', text: 'This is Second post', author_id: @user.id)
    Post.create(title: 'Hello', text: 'This is Third post', author_id: @user.id)
  end

  describe 'post index page' do
    it 'shows the user index page' do
      visit "/users/#{@user.id}/posts"
      # I can see the user's profile picture.
      expect(page).to have_css('img[src*="https://i.imgur.com/1J3wQYt.jpg"]')
      # I can see the user's username.
      expect(page).to have_content(@user.name)
      # I can see the number of posts the user has written.
      expect(page).to have_content('Number of posts: 3')
      # I can see a post's title.
      expect(page).to have_content(@post.title)
      # I can see some of the post's body.
      expect(page).to have_content(@post.text)
      # I can see the first comments on a post.
      expect(page).to have_content(@comment.text)
      # I can see how many comments a post has.
      expect(page).to have_content('Number of comments: 1')
      # I can see how many likes a post has.
      expect(page).to have_content('Number of likes: 0')
      # When I click on a post, it redirects me to that post's show page.
      click_on @post.title
      expect(page).to have_current_path("/users/#{@user.id}/posts/#{@post.id}")
    end
  end

  describe 'post show page' do
    it 'shows the post show page' do
      visit "/users/#{@user.id}/posts/#{@post.id}"
      # I can see the post's title.
      expect(page).to have_content(@post.title)
      # I can see who wrote the post.
      expect(page).to have_content(@user.name)
      # I can see how many comments it has.
      expect(page).to have_content('Number of comments: 1')
      # I can see how many likes it has.
      expect(page).to have_content('Number of likes: 0')
      # I can see the post body.
      expect(page).to have_content(@post.text)
      # I can see the username of each commentor.
      expect(page).to have_content(@second_user.name)
      # I can see the comment each commentor left.
      expect(page).to have_content(@comment.text)
    end
  end
end
