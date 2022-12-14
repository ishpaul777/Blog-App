class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  after_initialize :init

  validates :name, presence: true
  validates :postCounter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  Roles = %i[admin default].freeze

  def is?(requested_role)
    role == requested_role.to_s
  end

  def as_json(_options = {})
    super(only: %i[id name postCounter])
  end

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def update_posts_count
    update(postCounter: posts.count)
  end

  private

  # this will set the user's postCounter to the number of posts they have
  def init
    self.postCounter ||= 0
  end
end
