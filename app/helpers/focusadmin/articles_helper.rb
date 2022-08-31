module Focusadmin
  module ArticlesHelper

  	def status_view(article)
  		case  article.status
  		when "published" then
  			return t('.published')
      when "reviewing" then
        return t('.reviewing')
  		when "draft" then
        if article.rejected_at.present?
          return t('.rejected')
        else
    			return t('.draft')
        end
  		end
  	end

  end
end
