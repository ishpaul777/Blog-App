require 'rails_helper'

RSpec.describe Post, type: :model do
  first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  subject { described_class.new(author: first_user, title: 'Hello', text: 'This is my first post') }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'likesCounter is 0 when there are no likes by user' do
    expect(subject.likesCounter).to eq(0)
  end

  it 'likes counter should be a integer' do
    subject.likesCounter = 'Sandwich'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a likesCounter not a number' do
    subject.likesCounter = 'a'
    expect(subject).to_not be_valid
  end

  it 'commentsCounter is 0 when there are no comments by user' do
    expect(subject.commentsCounter).to eq(0)
  end

  it 'comments counter should be a integer' do
    subject.commentsCounter = 'Sandwich'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a commentsCounter not a number' do
    subject.commentsCounter = 'a'
    expect(subject).to_not be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'user has 1 post' do
    expect(first_user.postCounter).to eq(1)
  end
end
