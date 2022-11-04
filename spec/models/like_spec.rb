require 'rails_helper'

RSpec.describe Like, type: :model do
  first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  second_user = User.create(name: 'John', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            bio: 'Teacher from Mexico.')
  post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
  subject { described_class.new(author: second_user, post:) }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a user' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'post has 1 like' do
    expect(post.likesCounter).to eq(1)
  end
end
