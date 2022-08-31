require_dependency "focusadmin/application_controller"

module Focusadmin
  class BannersController < ApplicationController
    before_action :set_banner, only: [:show, :edit, :update, :destroy]

    def update_row_order
      @banner = Banner.find(banner_params[:banner_id])
      @banner.row_order_position = banner_params[:row_order_position]
      @banner.save

      render nothing: true
    end

    def index
      @banners = Banner.rank(:row_order)
    end

    def new
      @banner = Banner.new
    end

    def create
      @banner = Banner.new(banner_params)

      respond_to do |format|
        if @banner.save
          format.html { redirect_to banners_url, notice: 'Banner was successfully created.' }
          format.json { render :show, status: :created, location: @banner }
        else
          format.html { render :new }
          format.json { render json: @banner.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @banner.update(banner_params)
          format.html { redirect_to @banner, notice: 'Banner was successfully updated.' }
          format.json { render :show, status: :ok, location: @banner }
        else
          format.html { render :edit }
          format.json { render json: @banner.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @banner.destroy
      respond_to do |format|
        format.html { redirect_to banners_url, notice: 'Banner was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_banner
        @banner = Banner.find(params[:id])
      end

      def banner_params
        params.require(:banner).permit(:banner, :link, :target, :memo, :row_order, :row_order_position, :banner_id)
      end

  end

end
