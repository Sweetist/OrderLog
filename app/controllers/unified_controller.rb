class UnifiedController < ApplicationController

  before_action :load_table, only: [:index]

  def index
  end

  private
    def load_table
      @headers = []
      @headers[0]=Delivery.columns_hash
      @headers[1]=Order.columns_hash
      @headers[2]=Bakery.columns_hash
      @headers[3]=Recipient.columns_hash
      @data = Delivery.all
      @table = Delivery.new
    end

end