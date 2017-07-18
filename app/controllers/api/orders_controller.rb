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
        @datum.save
        if (params[:bakery])
          bakery = Bakery.find_or_initialize_by(name: params[:bakery][:name])
          bakery.update_attributes(params[:bakery].permit(Bakery.column_names))
          bakery.save
          @datum.bakery_id = bakery.id
        end
        if (params[:recipient])
          recipient = Recipient.find_or_initialize_by(first_name: params[:recipient][:first_name], last_name: params[:recipient][:last_name])
          recipient.update_attributes(params[:recipient].permit(Recipient.column_names))
          recipient.save
          @datum.recipient_id = recipient.id
        end
        if (params[:line_items])
          items = params[:line_items]
          items.each do |i|
            puts i
            line_item = LineItem.find_or_initialize_by(id: i[:id])
            line_item.update_attributes(i.permit(LineItem.column_names))
            line_item.order_id = @datum.id
            line_item.save
          end
        end
        @datum.update_attributes(order_params)
        @datum.save

        @datum.delivery.update_attributes(params.permit(Delivery.column_names-Order.column_names))

        @datum.delivery.save
        render json: { message: "order saved"}
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
        render json: @datum.to_json(
          :include => [:line_items, :bakery, :recipient])
      end
    end

    private
    def order_params
      permittable = Order.column_names
      permittable.append("bakery")
      permittable.append("bakery_id")
      params.permit(permittable)
    end

    def load_order
      @datum = Order.find_by(id: params[:id])
    end

  end
end