class OrdersController < ApplicationController
  before_action :load_table, only: [:index, :show]
  before_action :load_order, only: [:edit, :create, :show, :destroy]

  def index
  end

  def create
    @datum = Order.find_or_initialize_by(id: params[:order][:id])
    @datum.update_attributes(order_params)
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
      @headers = Order.columns_hash
      @data = Order.all
      @table = Order.new
    end

    def order_params
      params.require(:order).permit(Order.column_names)
    end

    def load_order
      @datum = Order.find_by(id: params[:id])
    end

end