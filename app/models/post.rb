class Post < ApplicationRecord
	belongs_to :author, class_name: "User"
	has_many :comments
	has_many :likes
	after_save :update_user_posts_count

	def update_user_posts_count
		author.update_posts_count
	end
	
	def update_likes_count
		update(likesCounter: self.likes.count)
	end

	def update_comments_count
		update(commentsCounter: self.comments.count)
	end
end