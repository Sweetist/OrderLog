module Api
  class Api::LineItemsController < Api::BaseController

    before_action :load_line_item, only: [:create, :show, :destroy, :update, :transition]

    def create
      if params[:find]
        @datum= LineItem.find_by(line_item_number: params[:line_item_number])
        if request.referer == line_items_url
          redirect_to line_item_path(@datum.id)
        end
      else
        @datum = LineItem.find_or_initialize_by(id: params[:id])
        @datum.update_attributes(line_item_params)
        @datum.save
      end
    end

    def update
      @datum.update_attributes(line_item_params)
      @datum.save
    end

    def destroy
      @datum.destroy
    end

    def show
      if @datum.nil?
        render json: { message: "line_item not found", status: :not_found }
      else
        render json: @datum.to_json
      end
    end

    private
    def line_item_params
      params.permit(LineItem.column_names)
    end

    def load_line_item
      @datum = LineItem.find_by(id: params[:id])
    end
  end
end