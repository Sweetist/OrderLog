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
        params = ActionController::Parameters.new(JSON.parse(request.body.string))
        @datum = Order.find_or_initialize_by(id: params[:id])
        @datum.save
        if (params[:bakery])
          bakery = Bakery.find_or_initialize_by(name: params[:bakery][:name])
          bakery.update_attributes(params[:bakery].permit(Bakery.column_names))
          bakery.save
          @datum.bakery_id = bakery.id
        end
        if (params[:ship_address])
          address = Address.find_or_initialize_by(id: params[:ship_address][:id])
          address.update_attributes(params[:ship_address].permit(Address.column_names))
          address.save

          if (params[:recipient])
            recipient = Recipient.find_or_initialize_by(first_name: params[:recipient][:first_name], last_name: params[:recipient][:last_name])
            recipient.update_attributes(params[:recipient].permit(Recipient.column_names))
            recipient.address_id = address.id
            recipient.save
            @datum.recipient_id = recipient.id
          else
            recipient = Recipient.find_or_initialize_by(first_name: params[:ship_address][:firstname], last_name: params[:ship_address][:lastname])
            recipient.address_id = address.id
            recipient.save
            @datum.recipient_id = recipient.id
          end
        end
        if (params[:line_items])
          items = params[:line_items]
          items.each do |i|
            line_item = LineItem.find_or_initialize_by(id: i[:id])
            line_item.update_attributes(i.permit(LineItem.column_names))
            line_item.order_id = @datum.id
            line_item.save
          end
        end

        @datum.delivery.save
        @datum.update_attributes(order_params(params))
        @datum.save
        
        if !@datum.delivery.update_attributes(params.permit(Delivery.column_names-Order.column_names-[:state, "state"]))
          puts @datum.delivery.errors.full_messages
          puts @datum.errors.full_messages
        end

        if !@datum.delivery.save
          puts @datum.delivery.errors.full_messages
          puts @datum.errors.full_messages
        end


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
    def order_params(params=params)
      params.permit(Order.column_names)
    end

    def load_order
      @datum = Order.find_by(id: params[:id])
    end

  end
end