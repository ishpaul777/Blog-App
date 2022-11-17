class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_post_comments_count
  after_destroy :update_post_comments_count

  validates :text, presence: true

  def update_post_comments_count
    post.update_comments_count
  end

  def as_json(_options = {})
    super(only: %i[text author_id post_id])
  end
end
