class DeliveriesController < ApplicationController

  before_action :load_table, only: [:index, :show]
  before_action :load_delivery, only: [:edit, :create, :show, :destroy]

  def index
  end

  def create
    @datum = Delivery.find_or_initialize_by(id: params[:delivery][:id])
    @datum.update_attributes(delivery_params)
    @datum.save
  end

  def destroy
    @datum.destroy
  end

  def show
    render 'index'
  end

  private
    def load_table
      @headers = Delivery.columns_hash
      @data = Delivery.all
      @table = Delivery.new
    end

    def delivery_params
      params.require(:delivery).permit(Delivery.column_names)
    end

    def load_delivery
      @datum = Delivery.find_by(id: params[:id])
    end

end