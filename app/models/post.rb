class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_user_posts_count

	
	def recent_comments
		comments.order('created_at Desc').limit(5)
	end

	private
	def update_user_posts_count
		author.update_posts_count
	end

  def update_likes_count
    update(likesCounter: likes.count)
  end

  def update_comments_count
    update(commentsCounter: comments.count)
  end
end
