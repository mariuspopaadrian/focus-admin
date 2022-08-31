require_dependency "focusadmin/application_controller"

module Focusadmin
  class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def products
      @q = Item.where(item_type: "product").includes(:article).ransack(params[:q])
      @items = @q.result(distinct: true).order(created_at: "DESC").page params[:page]
    end

    def events
      @events = Item.where(item_type: "event").includes(:article).order(event_start_date: :desc)
    end

    private
      def set_item
        @item = Item.find(params[:id])
      end

  end
end
