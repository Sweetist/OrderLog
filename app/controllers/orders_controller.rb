class OrdersController < ApplicationController
  before_action :load_delivery, only: [:destroy]

  def index
    @headers = Order.columns_hash
    @data = Order.all
    @table = Order.new
  end

  def destroy
    @order.destroy
  end

  private

    def load_delivery
      @order = Order.find_by(id: params[:id])
    end
end