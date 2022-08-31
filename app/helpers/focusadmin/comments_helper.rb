module Focusadmin
  module CommentsHelper

  	def commented_article(comment)
      @article = Article.find(comment.commentable_id)
  	end

  end
end
