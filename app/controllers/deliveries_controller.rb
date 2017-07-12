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

      #puts @datum.errors.full_messages

      respond_to do |format|
        format.js
      end
      
        redirect_to deliveries_url
      
    end
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
    case transition
    when "assign"
      @datum.assign
    when "begin_delivery"
      @datum.begin_delivery
    when "pickup_order"
      @datum.pickup_order
    when "deliver" 
      @datum.deliver
    when "request_feedback"
      @datum.request_feedback
    when "receive_feedback"
      @datum.receive_feedback
    when "report_issue"
      @datum.report_issue
    when "resolve_issue" 
      @datum.resolve_issue
    end
    @datum.save
    redirect_to deliveries_url
  end

  private
  def load_table
    @readonly=["pickup_time", "dropoff_time", "is_on_time", "state"]
    @transitions = [:assign, :begin_delivery, :pickup_order, :deliver, 
      :request_feedback, :receive_feedback, :report_issue, :resolve_issue]
      @headers = [Delivery.columns_hash]

      @data = Delivery.all

      @table = Delivery.new
      @visible = ["delivery_number", "order_number", "bakery_id", "courier_service", "scheduled_collection", "scheduled_delivery", "order_id", "state"]
      @bakery_ids = []
      @recipient_ids = []
      @order_ids = []

      orders = Order.all
      orders.each do |o|
        @order_ids.push("#{o.id} - #{o.order_number}")
      end

      bakeries = Bakery.all
      bakeries.each do |b|
        @bakery_ids.push("#{b.id} - #{b.name}")
      end
    end

    def delivery_params
      allowed = Delivery.column_names
      allowed.delete("state")
      params.require(:delivery).permit(allowed)
    end

    def load_delivery
      @datum = Delivery.find_by(id: params[:id])
    end
  end