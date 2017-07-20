 class BakeriesController < ApplicationController

  before_action :load_table, only: [:new, :edit, :index, :show]
  before_action :load_bakery, only: [:edit, :create, :show, :destroy]

  def new
  end

  def edit
    render 'new'
  end

  def index
  end

  def create
    if params[:find]
      @datum= Bakery.find_by(name: params[:bakery][:name])
      puts @datum
      respond_to do |format|
        format.js
      end

      if request.referer == bakeries_url
        redirect_to bakery_path(@datum.id)
        #redirect_to edit_bakery_path(@datum.id)
      end

    else
      @datum = Bakery.find_or_initialize_by(id: params[:bakery][:id])
      @datum.update_attributes(bakery_params)

      if @datum.save
        flash[:notice] = "Successfully updated"
      else
        flash[:error] = "Error:" + @datum.errors.full_messages
      end

      respond_to do |format|
        format.js
      end

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
    @readonly=[]
    @transitions=[]
      @headers = [Bakery.columns_hash]
      @data = Bakery.all
      @table = Bakery.new
      @visible = Bakery.column_names
      @address_ids=[]
    end

    def bakery_params
      params.require(:bakery).permit(Bakery.column_names)
    end

    def load_bakery
      @datum = Bakery.find_by(id: params[:id])
    end

end