require_dependency "focusadmin/application_controller"
require "koala"
require "twitter"

module Focusadmin
  class ArticlesController < ApplicationController
    include CloudinaryHelper
    before_action :set_article, only: [:edit, :update]

    def index
      @q = Article.all.includes(:user).ransack(params[:q])
      @articles = @q.result(distinct: true).order(id: "DESC").page(params[:page]).per(100)

      articles_published = Article.where(status: "published")
      @articles_published_count = articles_published.count
    end

    def edit
    end

    def update
      if params[:article].present? and params[:article][:title].present?
        @article.update(article_params)
        respond_to do |format|
          format.html { redirect_to articles_url, notice: 'article was successfully updated.' }
        end
      else

      	if params[:status_change_button] == "下書きに戻す" || params[:status_change_button] == "Unpublish"
  		    respond_to do |format|
  		      @article.status = "draft"
  		      @article.save
  		      @article_id = @article.id
  		      @action = "change_to_draft"
  		      format.js
  		    end
  		  elsif params[:status_change_button] == "差し戻す" || params[:status_change_button] == "Reject"
  		    respond_to do |format|
  		      @article.status = "draft"
  		      @article.rejected_at = Time.zone.now
  		      @article.reject_reason = params[:reject_reason]
  		      @article.reject_message = params[:reject_message]
  		      @article.save
  		      @action = "reject"
  		      ArticleMailer.review_result_notification_email(@article.user, @article, @action).deliver_later
	      	  format.html { redirect_to review_url, notice: t('.article_has_been_rejected') }
  		    end
        elsif params[:status_change_button] == "公開を予約する" || params[:status_change_button] == "Publish on Schedule"
          respond_to do |format|
            @article.status = "scheduled"

            if params[:facebook].present?
              @article.facebook_post = params[:facebook_post_message] if params[:facebook][:post] == "true" #params come in as strings
            end

            if params[:twitter].present?
              @article.twitter_post = params[:twitter_post_message] if params[:twitter][:post] == "true" #params come in as strings
            end

            article = params[:article]
            @article.publish_on_schedule_at = Time.new(article["publish_on_schedule_at(1i)"].to_i, article["publish_on_schedule_at(2i)"].to_i, article["publish_on_schedule_at(3i)"].to_i, article["publish_on_schedule_at(4i)"].to_i, article["publish_on_schedule_at(5i)"].to_i)
            @article.save
            @action = "scheduled"
            format.html { redirect_to review_url, notice: t('.article_has_been_scheduled') }
          end
        elsif params[:cancel_schedule_button] == "キャンセル" || params[:cancel_schedule_button] == "Cancel"
          respond_to do |format|
            @article.status = "reviewing"
            @article.publish_on_schedule_at = ""
            @article.save
            @article_id = @article.id
            @action = "cancelled_schedule"
            format.js
          end
        else
          respond_to do |format|
            @article.status = "published"
            @article.published_at = Time.zone.now
            @article.save
            @article_id = @article.id
            @action = "publish"
            ArticleMailer.review_result_notification_email(@article.user, @article, @action).deliver_later

            if params[:facebook].present?
              post_to_facebook(params[:facebook_post_message]) if params[:facebook][:post] == "true" #params come in as strings
            end

            if params[:twitter].present?
              tweet(params[:twitter_post_message]) if params[:twitter][:post] == "true" #params come in as strings
            end

            format.html { redirect_to review_url, notice: t('.article_has_been_published') }
          end
        end

      end
    end

    def review
      @q = Article.reviewing.includes(:user).ransack(params[:q])
      @articles = @q.result(distinct: true).order(id: "DESC")
      @articles_waiting_review = Article.reviewing.includes(:user).includes(:category).order(updated_at: :desc)
      @articles_waiting_review_count = @articles_waiting_review.count
    end

    def scheduled
      @q = Article.scheduled.includes(:user).ransack(params[:q])
      @articles = @q.result(distinct: true).order(id: "DESC")
      @scheduled_articles = Article.scheduled.includes(:user).order(publish_on_schedule_at: :asc)
      @scheduled_articles_count = @scheduled_articles.count
    end

	  private
	    def set_article
	      @article = Article.find(params[:id])
	    end

	    def article_params
	      params.require(:article).permit(:title, :excerpt, :body, :slug, :thumbnail, :category_id, :status, :tag_list, :published_at, :rejected_at, :reject_reason, :reject_message, :publish_on_schedule_at, :initially_submitted_at,
          :facebook, :facebook_post_message, :twitter, :twitter_post_message,
          :pr, :sponsor, :pr_start, :pr_end, :pr_pickup)
	    end

      def tweet(twitter_post_message)

        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
          config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end

        client.update(twitter_post_message + "\nhttps://#{ENV['CANONICAL_HOST']}/#{@article.id}")
      end

      def post_to_facebook(facebook_post_message)

        image_url = cl_image_path(@article.thumbnail, :width => 1200)
        @api = Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_ACCESS_TOKEN'])
        @api.put_wall_post(facebook_post_message, {
          "name" => @article.title,
          "link" => "https://#{ENV['CANONICAL_HOST']}/#{@article.id}", # must be absolute path
          "description" => @article.excerpt,
          "picture" => image_url
        })

      end

  end
end
