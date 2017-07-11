module Api
  class Api::BakeriesController < Api::BaseController
    before_action :load_bakery, only: [:create, :show, :destroy, :update]
    #include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_user


    def create
      if params[:find]
        @datum= Bakery.find_by(name: params[:name])
        if request.referer == bakeries_url
          redirect_to bakery_path(@datum.id)
        end
      else
        @datum = Bakery.find_or_initialize_by(id: params[:id])
        @datum.update_attributes(bakery_params)
        @datum.save
      end
    end

    def destroy
      @datum.destroy
    end

    def update
      @datum.update_attributes(bakery_params)
      @datum.save
    end

    def show
      if @datum.nil?
        render json: { message: "bakery not found", status: :not_found }
      else
        render json: @datum.to_json
      end
    end

    private

    def load_table
      @headers = [Bakery.columns_hash]
      @data = Bakery.all
      @table = Bakery.new
      @visible = Bakery.column_names
    end

    def bakery_params
      params.permit(Bakery.column_names)      
    end

    def load_bakery
      @datum = Bakery.find_by(id: params[:id])
    end

  end
end