class DeliveriesController < ApplicationController

  before_action :load_delivery, only: [:destroy]

  def index
  	@headers = Delivery.columns_hash
    @data = Delivery.all
    @table = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.save
  end

  def destroy
    @delivery.destroy
  end

  private

    def delivery_params
      params.require(:delivery).permit(Delivery.column_names)
    end

    def load_delivery
      @delivery = Delivery.find_by(id: params[:id])
    end

end