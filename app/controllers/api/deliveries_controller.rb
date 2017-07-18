module Api
  class Api::DeliveriesController < Api::BaseController

    before_action :load_delivery, only: [:create, :show, :destroy, :update, :transition]

    def create
      if params[:find]
        @datum= Delivery.find_by(delivery_number: params[:delivery_number])
        if request.referer == deliveries_url
          redirect_to delivery_path(@datum.id)
        end
      else
        @datum = Delivery.find_or_initialize_by(id: params[:id])
        @datum.update_attributes(delivery_params)
        @datum.save
        render json: { message: "delivery saved"}
      end
    end

    def update
      @datum.update_attributes(delivery_params)
      @datum.save
    end

    def destroy
      @datum.destroy
    end

    def transition
      transition = params[:transition]
      case transition
      when "assign"
        if !@datum.assign
          render json: { error: @datum.errors.full_messages }
        end
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
      render json: { memory: @datum.to_json, db: Delivery.find_by(id: params[:id]).to_json }
      #render json: { message: "successful transition" }
    end

    def show
      if @datum.nil?
        render json: { message: "delivery not found", status: :not_found }
      else
        render json: @datum.to_json
      end
    end

    private
    def delivery_params
      params.permit(Delivery.column_names)
    end

    def load_delivery
      @datum = Delivery.find_by(id: params[:id])
    end
  end
end