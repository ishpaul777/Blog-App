require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'postCounter is 0 when there are no post by user' do
    expect(subject.postCounter).to eq(0)
  end

  it 'posts counter should be a integer' do
    subject.postCounter = 'Sandwich'
    expect(subject).to_not be_valid
  end

  it 'is not valid with a postCounter not a number' do
    subject.postCounter = 'a'
    expect(subject).to_not be_valid
  end
end
