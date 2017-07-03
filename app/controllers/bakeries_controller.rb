class BakeriesController < ApplicationController

  before_action :load_table, only: [:index, :show]
  before_action :load_bakery, only: [:edit, :create, :show, :destroy]

  def index
  end

  def create
    if params[:find]
      @datum= Bakery.find_by(name: params[:bakery][:name])
    else
      @datum = Bakery.find_or_initialize_by(id: params[:bakery][:id])
      @datum.update_attributes(bakery_params)
      @datum.save
      redirect_to bakeries_url
    end
  end

  def destroy
    @datum.destroy
    redirect_to bakeries_url
  end

  def show
    render 'index'
  end

  private

    def load_table
      @headers = Bakery.columns_hash
      @data = Bakery.all
      @table = Bakery.new
    end

    def bakery_params
      params.require(:bakery).permit(Bakery.column_names)
    end

    def load_bakery
      @datum = Bakery.find_by(id: params[:id])
    end

end