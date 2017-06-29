class BakeriesController < ApplicationController

  before_action :load_bakery, only: [:destroy]

  def index
  	@headers = Bakery.columns_hash
  	@data = Bakery.all
    @table = Bakery.new
  end

  def destroy
    @bakery.destroy
  end

  private

    def load_bakery
      @bakery = Bakery.find_by(id: params[:id])
    end
end