class DeliveriesController < ApplicationController

  before_action :load_table, only: [:new, :index, :show, :edit]
  before_action :load_delivery, only: [:edit, :create, :show, :destroy, :transition]

  def new
  end

  def index
  end

  def edit
    render 'new'
  end

  def create
    if params[:find]
      @datum= Delivery.find_by(delivery_number: params[:delivery][:delivery_number])
      respond_to do |format|
        format.js
      end
      if request.referer == deliveries_url
        redirect_to edit_delivery_path(datum.id)
      end
    else
      @datum = Delivery.find_or_initialize_by(id: params[:delivery][:id])
      @datum.save

      if !@datum.update_attributes(delivery_params)
        flash[:error] = @datum.errors.full_messages
      end

      respond_to do |format|
        format.js
      end

      redirect_to deliveries_url
    end
  end

  def update
    @datum = Delivery.find_by(id: params[:delivery][:id])
    if !@datum.update(delivery_params)
      flash[:error] = @datum.errors.full_messages
    end
    redirect_to deliveries_url
  end

  def destroy
    @datum.destroy
    redirect_to deliveries_url
  end

  def show
    render 'index'
  end

  def transition
    transition = params[:transition]
    if @datum.send(transition)
      flash[:success] = 'Delivery state transitioned'
    else
      flash[:error] = @datum.errors.full_messages
    end
    redirect_to deliveries_url
  end

  private
  def load_table
    @visible = ["id","delivery_number", "number", "date", "bakery_id", "courier_service", "scheduled_collection", "scheduled_delivery", "order_id", "state"]
    #@visible = Delivery.column_names
    @readonly=["pickup_time", "dropoff_time", "is_on_time", "state"]

    @transitions = {
      new: [:assign, :report_issue],
      assigned: [:begin_delivery, :report_issue],
      en_route_to_pickup: [:pickup_order, :report_issue],
      out_for_delivery: [:deliver, :report_issue],
      delivered: [:request_feedback],
      feedback_requested: [:receive_feedback],
      issue_reported: [:resolve_issue],
      issue_resolved: [:assign, :begin_delivery, :pickup_order, :deliver],
      complete: [],
      canceled: []
    }
    
    @headers = [Delivery.columns_hash]

    @data = Delivery.all.sort do |a,b|
      a.id <=> b.id
    end

    @table = Delivery.new
    @order_ids = []

    orders = Order.all
    orders.each do |o|
      @order_ids.push("#{o.id} - #{o.number}")
    end

  end

  def delivery_params
    permitted = Delivery.column_names
    #we first reject the empty fields (id, created_at, updated_at, etc. to prevnet db violation)
    params.require(:delivery).reject{|hash, val| val.blank?}.permit(permitted)
  end

  def load_delivery
    @datum = Delivery.find_by(id: params[:id])
  end
end