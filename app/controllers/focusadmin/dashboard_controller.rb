require_dependency "focusadmin/application_controller"

module Focusadmin
  class DashboardController < ApplicationController
    def index
    	@articles_count = Article.all.count
    	@users_count = User.all.count
    	@articles_waiting_review = Article.where(status: "reviewing").includes(:user).includes(:category).order(updated_at: :desc)
    	@articles_waiting_review_count = @articles_waiting_review.count

      @favorites = Favorite.all.count
    end

    def rankings
      @top_curators_by_pv = User.order("pageview_sum_of_all_articles DESC NULLS LAST").limit(30)
      @top_articles = GaPageview.includes(:article).includes(:user).order(count: "DESC").limit(30)
    end
  end
end
