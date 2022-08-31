require_dependency "focusadmin/application_controller"

module Focusadmin
  class AreasController < ApplicationController
    before_action :set_area, only: [:edit, :update, :destroy]

    def update_row_order
      @area = Area.find(area_params[:area_id])
      @area.row_order_position = area_params[:row_order_position]
      @area.save

      render nothing: true
    end

    def index
      @areas = Area.rank(:row_order).all
    end

    def new
      @area = Area.new
    end

    def edit
    end

    def create
      @area = Area.new(area_params)

      respond_to do |format|
        if @area.save
          format.html { redirect_to areas_url, notice: 'area was successfully created.' }
          format.json { render :index, status: :created, location: @area }
        else
          format.html { render :new }
          format.json { render json: @area.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @area.update(area_params)
          format.html { redirect_to areas_url, notice: 'area was successfully updated.' }
          format.json { render :index, status: :ok, location: @area }
        else
          format.html { render :edit }
          format.json { render json: @area.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      def set_area
        @area = Area.find(params[:id])
      end

      def area_params
        params.require(:area).permit(:name, :slug, :description, :visibility, :ancestry, :thumbnail, :thumbnail2, :thumbnail3, :row_order_position, :area_id)
      end

  end
end
