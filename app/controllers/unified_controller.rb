class UnifiedController < ApplicationController

  before_action :load_table, only: [:index]

  def index
  end

  def create
    redirect_to url_for(:controller => "deliveries", :action => "create") and return
  end

  def edit
    redirect_to url_for(:controller => "deliveries", :action => "edit") and return
  end

  private
    def load_table
    @readonly=[]
      data_classes = [Delivery, Order, Bakery, Recipient]
      
      @headers = []
      @visible = []
      data_classes.each do |table|
        @headers.push(table.columns_hash)
        @visible.concat(table.column_names)
      end
      @bakery_ids = []
      bakeries = Bakery.all
      bakeries.each do |b|
        @bakery_ids.push("#{b.id} - #{b.name}")
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

      @viewable_fields = ["name", "order_number"]
    end
    
end