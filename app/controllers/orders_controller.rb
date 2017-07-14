class OrdersController < ApplicationController

  before_action :load_table, only: [:new, :index, :show, :edit]
  before_action :load_order, only: [:create, :show, :destroy, :edit]

  def new
  end

  def index
  end

  def edit
    render 'new'
  end

  def create
    if params[:find]
      @datum= Order.find_by(number: params[:order][:number])

      respond_to do |format|
        format.js
      end

      if request.referer == orders_url
        redirect_to order_path(@datum.id)
      end

    else
      @datum = Order.find_or_initialize_by(id: params[:order][:id])
      @datum.update_attributes(order_params)
      @datum.save

      respond_to do |format|
        format.js
      end

      if request.referer == orders_url
        redirect_to orders_url
      end
    end
  end

  def destroy
    @datum.destroy
    redirect_to orders_url
  end

  def show
    render 'index'
  end

  private

    def load_table
      @transitions=[]
    @readonly=[]
      @headers = [Order.columns_hash]
      @data = Order.all
      @table = Order.new
      @bakery_ids = []
      bakeries = Bakery.all
      bakeries.each do |b|
        @bakery_ids.push("#{b.id} - #{b.name}")
      end
      @visible = Order.column_names
    end

    def order_params
      params.require(:order).permit(Order.column_names)
    end

    def load_order
      @datum = Order.find_by(id: params[:id])
    end

end