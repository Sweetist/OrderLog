class StateTestsController < ApplicationController

  def show
  	render json: StateTest.find_by(id: params[:id]).to_json
  end

  def transition
    statetest = StateTest.find_by(id: params[:id])
    statetest.next
    redirect_to action: "show", id: params[:id]
  end

  def new
  	statetest = StateTest.new
 	statetest.save
  end

end