class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_post_comments_count

  validates :text, presence: true

  def update_post_comments_count
    post.update_comments_count
  end
end
