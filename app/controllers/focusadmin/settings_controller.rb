require_dependency "focusadmin/application_controller"

module Focusadmin
  class SettingsController < ApplicationController
	  before_action :set_setting, only: [:show, :edit, :update, :destroy]

	  def index
	    @settings = Setting.all
	  end

	  def show
	  end

	  def new
	    @setting = Setting.new
	  end

	  def edit
	  end

    def edit_pages
    end

	  def create
	    @setting = Setting.new(setting_params)

	    respond_to do |format|
	      if @setting.save
	        format.html { redirect_to settings_url, notice: 'Setting was successfully created.' }
	        format.json { render :show, status: :created, location: @setting }
	      else
	        format.html { render :new }
	        format.json { render json: @setting.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    respond_to do |format|
	      if @setting.update(setting_params)
	        format.html { redirect_to settings_url, notice: 'Setting was successfully updated.' }
	        format.json { render :show, status: :ok, location: @setting }
	      else
	        format.html { render :edit }
	        format.json { render json: @setting.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def destroy
	    @setting.destroy
	    respond_to do |format|
	      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end

	  private
	    def set_setting
	      @setting = Setting.find(params[:id])
	    end

	    def setting_params
	      params.require(:setting).permit(:site_name, :catch, :site_logo_image, :author, :meta_description, :og_description, :og_image, :favicon, :apple_touch_icon, :locale, :concept_page_html, :facebook_page_url, :twitter_account_url, :instagram_account_url, :line_account_url, :author_url, :author_url_anchor_text, :sp_site_logo_image, :footer_logo_image, :privacy_page_html, :terms_page_html, :curator_terms_page_html, :welcome_page_html, :welcome_page_url, :smartnews_logo_image, :site_name_supplement, :exclude_tags, :exclude_brands, :recent_articles_tab_text, 
	      	:free_field1_question)
	    end
	end
end
