require_dependency "focusadmin/application_controller"

module Focusadmin
  class TagController < ApplicationController

    def index
      # don't use @tags here because its in use globally
      @tag_list = Article.published.tag_counts_on(:tags).order(taggings_count: 'DESC').page(params[:page]).per(100)
    end

  end
end
