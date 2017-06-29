class RecipientsController < ApplicationController

  before_action :load_table, only: [:index, :show]
  before_action :load_recipient, only: [:edit, :create, :show, :destroy]

  def index
  end

  def create
    @datum = Recipient.find_or_initialize_by(id: params[:recipient][:id])
    @datum.update_attributes(recipient_params)
    @datum.save
  end

  def destroy
    @datum.destroy
  end

  def show
    render 'index'
  end

  private

    def load_table
      @headers = Recipient.columns_hash
      @data = Recipient.all
      @table = Recipient.new
    end

    def recipient_params
      params.require(:recipient).permit(Recipient.column_names)
    end

    def load_recipient
      @datum = Recipient.find_by(id: params[:id])
    end

end