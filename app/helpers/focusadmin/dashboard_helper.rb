module Focusadmin
  module DashboardHelper

    def published_article_count(user)
      published = Article.where(user_id: user.id).where(status: "published").count
      return published.to_s
    end

    def average_pv(pageview_sum_of_all_articles, published_article_count)
      unless published_article_count == "0"
        return (pageview_sum_of_all_articles / published_article_count.to_f).to_d.floor(1)
      else
        "-"
      end
    end

    def get_category_name(article)
      category_id = Article.find_by_id(article.id).category_id
      return Category.find_by_id(category_id).name if category_id.present?
    end

  end
end
