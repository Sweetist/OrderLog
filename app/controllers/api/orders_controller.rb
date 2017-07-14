module Api
  class Api::OrdersController < Api::BaseController

    before_action :load_order, only: [:create, :show, :destroy, :update]

    def create
      if params[:find]
        @datum= Order.find_by(number: params[:number])
        if request.referer == orders_url
          redirect_to order_path(@datum.id)
        end
      else
        @datum = Order.find_or_initialize_by(id: params[:id])
        @datum.update_attributes(order_params)
        @datum.save
      end
    end

    def update
      @datum.update_attributes(order_params)
      @datum.save
    end

    def destroy
      @datum.destroy
    end

    def show
      if @datum.nil?
        render json: { message: "order not found", status: :not_found }
      else
        render json: @datum.to_json
      end
    end

    private
    def order_params
      params.permit(Order.column_names)
    end

    def load_order
      @datum = Order.find_by(id: params[:id])
    end

  end
end