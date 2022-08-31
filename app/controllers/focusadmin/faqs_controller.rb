require_dependency "focusadmin/application_controller"

module Focusadmin
  class FaqsController < ApplicationController
    before_action :set_faq, only: [:edit, :update, :destroy]

    def update_row_order
      @faqs = Faq.find(faq_params[:faq_id])
      @faqs.row_order = faq_params[:row_order_position]
      @faqs.save

      render nothing: true
    end

    def index
      @faqs = Faq.rank(:row_order)
    end

    def new
      @faq = Faq.new
    end

    def edit
    end

    def create
      @faq = Faq.new(faq_params)

      respond_to do |format|
        if @faq.save
          format.html { redirect_to faqs_url, notice: 'Faq was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    def update
      respond_to do |format|
        if @faq.update(faq_params)
          format.html { redirect_to faqs_url, notice: 'Faq was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @faq.destroy
      respond_to do |format|
        format.html { redirect_to faqs_url, notice: 'Faq was successfully destroyed.' }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_faq
        @faq = Faq.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def faq_params
        params.require(:faq).permit(:question, :answer, :image, :row_order_position, :status, :faq_id)
      end
  end
end
