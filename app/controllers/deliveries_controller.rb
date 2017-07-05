class DeliveriesController < ApplicationController

  before_action :load_table, only: [:new, :index, :show, :edit]
  before_action :load_delivery, only: [:edit, :create, :show, :destroy]

  def new
  end

  def index
  end

  def edit
    render 'new'
  end

  def create
    if params[:find]
      @datum= Delivery.find_by(name: params[:delivery][:name])

      respond_to do |format|
        format.js
      end

      if request.referer == deliveries_url
        redirect_to delivery_path(@datum.id)
      end

    else
      @datum = Delivery.find_or_initialize_by(id: params[:delivery][:id])
      @datum.update_attributes(delivery_params)
      @datum.save


      respond_to do |format|
        format.js
      end

      if request.referer == deliveries_url || request.referer == unified_url
        redirect_to deliveries_url
      end

    end
  end

  def destroy
    @datum.destroy
    redirect_to deliveries_url
  end

  def show
    render 'index'
  end

  private
    def load_table
      #@headers = Delivery.columns_hash
      @headers = [Delivery.columns_hash]
      @headers[0].delete("pickup_time")
      @headers[0].delete("dropoff_time")
      @data = Delivery.all
      @table = Delivery.new
      @visible = ["delivery_number", "order_number", "bakery_id", "courier_service", "scheduled_collection", "scheduled_delivery", "is_on_time"]
    end

    def delivery_params
      params.require(:delivery).permit(Delivery.column_names)
    end

    def load_delivery
      @datum = Delivery.find_by(id: params[:id])
    end
end