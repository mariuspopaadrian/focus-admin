require_dependency "focusadmin/application_controller"

module Focusadmin
  class FeaturesController < ApplicationController
	  before_action :set_feature, only: [:edit, :update, :destroy]

  	def update_row_order
  	  @feature = Feature.find(feature_params[:feature_id])
  	  @feature.row_order_position = feature_params[:row_order_position]
  	  @feature.save

  	  render nothing: true
  	end

    def index
      @features = Feature.all
    end

    # GET /features/new
    def new
      @feature = Feature.new
    end

    # GET /features/1/edit
    def edit
    end

    # POST /features
    # POST /features.json
    def create
      @feature = Feature.new(feature_params)

      respond_to do |format|
        if @feature.save
          format.html { redirect_to features_url, notice: 'Feature was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    def update
      respond_to do |format|
        if @feature.update(feature_params)
          format.html { redirect_to features_url, notice: 'Feature was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @feature.destroy
      respond_to do |format|
        format.html { redirect_to features_url, notice: 'Feature was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

	  private
      def set_feature
        @feature = Feature.find(params[:id])
      end

      def feature_params
        params.require(:feature).permit(:name, :slug, :description, :featured_articles, :thumbnail, :row_order_position, :pageview_sum_of_all_articles, :pageview_monthly, :status, :feature_id)
      end

  end
end
