class RecipientsController < ApplicationController

  before_action :load_table, only: [:new, :index, :show, :edit]
  before_action :load_recipient, only: [:edit, :create, :show, :destroy]

  def new
  end

  def index
  end
  
  def edit
    render 'new'
  end

  def create
    if params[:find]
      @datum= Recipient.find_by(name: params[:recipient][:name])

      respond_to do |format|
        format.js
      end

      if request.referer == recipients_url
        redirect_to recipient_path(@datum.id)
      end

    else
      @datum = Recipient.find_or_initialize_by(id: params[:recipient][:id])
      @datum.update_attributes(recipient_params)
      @datum.save

      respond_to do |format|
        format.js
      end

      redirect_to recipients_url
    end
  end

  def destroy
    @datum.destroy
    redirect_to recipients_url
  end

  def show
    render 'index'
  end

  private

  def load_table
    @readonly=[]
    @transitions=[]
    @headers = [Recipient.columns_hash]
    @data = Recipient.all
    @table = Recipient.new
    @visible = Recipient.column_names
  end

  def recipient_params
    params.require(:recipient).permit(Recipient.column_names)
  end

  def load_recipient
    @datum = Recipient.find_by(id: params[:id])
  end

end