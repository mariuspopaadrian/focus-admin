require_dependency "focusadmin/application_controller"

module Focusadmin
  class CommentsController < ApplicationController

    def index
      @comments_count = Comment.all.count
    	@comments = Comment.all.includes(:user).order(id: "DESC")
    end

  end
end
