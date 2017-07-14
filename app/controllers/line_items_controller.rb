class LineItemsController < ApplicationController

  before_action :load_table, only: [:new, :edit, :index, :show]
  before_action :load_line_item, only: [:edit, :create, :show, :destroy]

  def new
  end

  def edit
    render 'new'
  end

  def index
  end

  def create
    if params[:find]
      @datum= LineItem.find_by(variant_id: params[:line_item][:variant_id])

      respond_to do |format|
        LineItem.js
      end

      if request.referer == line_items_url
        #redirect_to line_item_path(@datum.id)
        redirect_to edit_recipient_path(@datum.id)
      end
    else
      @datum = LineItem.find_or_initialize_by(id: params[:line_item][:id])
      @datum.update_attributes(line_item_params)


      if @datum.save
        flash[:notice] = "Successfully updated"
      else
        flash[:error] = "Error:" + @datum.errors.full_messages
      end
      
      respond_to do |format|
        format.js
      end

        redirect_to line_items_url
    end

  end

  def destroy
    @datum.destroy
    redirect_to line_items_url
  end

  def show
    render 'index'
  end

  private

    def load_table
    @readonly=[]
    @transitions=[]
      @headers = [LineItem.columns_hash]
      @data = LineItem.all
      @table = LineItem.new
      @visible = LineItem.column_names

      
      @order_ids = []

      orders = Order.all
      orders.each do |o|
        @order_ids.push("#{o.id} - #{o.number}")
      end
    end

    def line_item_params
      params.require(:line_item).permit(LineItem.column_names)
    end

    def load_line_item
      @datum = LineItem.find_by(id: params[:id])
    end
end