require_dependency "focusadmin/application_controller"

module Focusadmin
  class PickupsController < ApplicationController
    before_action :set_pickup, only: [:show, :edit, :update, :destroy]

    # GET /pickups
    def index
      @pickups = Pickup.all
    end

    # GET /pickups/new
    def new
      @pickup = Pickup.new
    end

    # GET /pickups/1/edit
    def edit
    end

    # POST /pickups
    def create
      @pickup = Pickup.new(pickup_params)

      if @pickup.save
        redirect_to pickups_url, notice: 'Pickup was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /pickups/1
    def update
      if @pickup.update(pickup_params)
        redirect_to pickups_url, notice: 'Pickup was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /pickups/1
    def destroy
      @pickup.destroy
      redirect_to pickups_url, notice: 'Pickup was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_pickup
        @pickup = Pickup.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def pickup_params
        params.require(:pickup).permit(:place, :pickup_type, :type_id, :order)
      end
  end
end
