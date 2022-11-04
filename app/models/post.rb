class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_user_posts_count
  after_initialize :init

  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :likesCounter, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  def recent_comments
    comments.order('created_at Desc').limit(5)
  end

  def update_likes_count
    update(likesCounter: likes.count)
  end

  def update_comments_count
    update(commentsCounter: comments.count)
  end

  private

  def init
    self.likesCounter ||= 0
    self.commentsCounter ||= 0
  end

  def update_user_posts_count
    author.update_posts_count
  end
end
