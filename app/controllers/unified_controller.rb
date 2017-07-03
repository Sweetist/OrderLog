class UnifiedController < ApplicationController

  before_action :load_table, only: [:index]

  def index
  end

  def create
    redirect_to url_for(:controller => "bakeries", :action => "create") and return
  end


  private
    def load_table
      data_classes = [Delivery, Order, Bakery, Recipient]
      
      @headers = []
      data_classes.each do |table|
        @headers.push(table.columns_hash)
      end

      @null_data = []
      data_classes.each do |table|
        @null_data.push(table.new)
      end
      
      @data = Delivery.all

      @null_delivery = Delivery.new
      @null_order = Order.new
      @null_bakery = Bakery.new
      @null_recipient = Recipient.new
    end
end