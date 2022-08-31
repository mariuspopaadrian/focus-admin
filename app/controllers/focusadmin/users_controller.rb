require_dependency "focusadmin/application_controller"

module Focusadmin
  class UsersController < ApplicationController
  	before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @q = User.includes(:roles).ransack(params[:q])
      @users = @q.result(distinct: true).order(created_at: "ASC").page params[:page]
    end

    def curator_applicants
      @q = User.where.not(submitted_at: nil).ransack(params[:q])
      @users = @q.result(distinct: true).order(created_at: "ASC").page params[:page]
    end

    def show
      @published_this_month = Article.where(user_id: @user.id).where(status: "published").where(published_at: Time.now.beginning_of_month..Time.now.end_of_month).count
      @published_last_month = Article.where(user_id: @user.id).where(status: "published").where(published_at: Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month).count
    end

    def edit
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: 'user was successfully updated.' }
          format.json { render :index, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:handlename, role_ids: [])
      end
  end
end
