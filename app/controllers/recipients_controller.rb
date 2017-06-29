class RecipientsController < ApplicationController

  before_action :load_recipient, only: [:destroy]

  def index
	@headers = Recipient.column_names
	@data = Recipient.all 
  @table = Recipient.new
  end

  def destroy
    @recipient.destroy
  end

  private

    def load_recipient
      @recipient = Recipient.find_by(id: params[:id])
    end
end