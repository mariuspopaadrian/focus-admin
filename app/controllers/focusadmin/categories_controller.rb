require_dependency "focusadmin/application_controller"

module Focusadmin
  class CategoriesController < ApplicationController
	  before_action :set_category, only: [:edit, :update, :destroy]

  	def update_row_order
  	  @category = Category.find(category_params[:category_id])
  	  @category.row_order_position = category_params[:row_order_position]
  	  @category.save

  	  render nothing: true
  	end

    def index
    	@categories = Category.rank(:row_order)
    end

	  def new
	    @category = Category.new
	  end

	  def edit
	  end

	  def create
	    @category = Category.new(category_params)

	    respond_to do |format|
	      if @category.save
	        format.html { redirect_to categories_url, notice: 'category was successfully created.' }
	        format.json { render :index, status: :created, location: @category }
	      else
	        format.html { render :new }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    respond_to do |format|
	      if @category.update(category_params)
	        format.html { redirect_to categories_url, notice: 'category was successfully updated.' }
	        format.json { render :index, status: :ok, location: @category }
	      else
	        format.html { render :edit }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def destroy
	    @category.destroy
	    respond_to do |format|
	      format.html { redirect_to categories_url, notice: 'category was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end

	  private
	    def set_category
	      @category = Category.find(params[:id])
	    end

	    def category_params
	      params.require(:category).permit(:name, :description, :slug, :thumbnail, :icon, :row_order, :row_order_position, :category_id)
	    end
  end
end
