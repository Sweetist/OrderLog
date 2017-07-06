module Api
  class RecipientsController < Api::BaseController
    before_action :load_recipient, only: [:create, :show, :destroy, :update]

    def create
      if params[:find]
        @datum= Recipient.find_by(name: params[:name])
        if request.referer == recipients_url
          redirect_to recipient_path(@datum.id)
        end
      else
        @datum = Recipient.find_or_initialize_by(id: params[:id])
        @datum.update_attributes(recipient_params)
        @datum.save
      end
    end

    def update
      @datum.update_attributes(recipient_params)
      @datum.save
    end

    def destroy
      @datum.destroy
    end

    def show
      if @datum.nil?
        render json: { message: "recipient not found", status: :not_found }
      else
        render json: @datum.to_json
      end
    end

    private
    def recipient_params
      params.permit(Recipient.column_names)
    end

    def load_recipient
      @datum = Recipient.find_by(id: params[:id])
    end

  end
end