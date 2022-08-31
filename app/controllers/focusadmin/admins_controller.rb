require_dependency "focusadmin/application_controller"

module Focusadmin
  class AdminsController < ApplicationController
  	before_action :set_admin, only: [:show, :edit, :update, :destroy]

    def index
    	@admins = Admin.all
    end

	  def new
	    @admin = Admin.new
	  end

	  def edit
	  end

	  def create
	    @admin = Admin.new(admin_params)

	    respond_to do |format|
	      if @admin.save
	        format.html { redirect_to admins_url, notice: 'Admin was successfully created.' }
	      else
	        format.html { render :new }
	        format.json { render json: @admin.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def update
	    respond_to do |format|
	      if @admin.update(admin_params)
	        format.html { redirect_to admins_url, notice: 'Admin was successfully updated.' }
	      else
	        format.html { render :edit }
	        format.json { render json: @admin.errors, status: :unprocessable_entity }
	      end
	    end
	  end

	  def destroy
	    @admin.destroy
	    respond_to do |format|
	      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end

    private
      def set_admin
        @admin = Admin.find(params[:id])
      end

	    def admin_params
	      params.require(:admin).permit(:email, :password, :password_confirmation)
	    end

  end
end
