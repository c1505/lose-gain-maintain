class WeightsController < ApplicationController
  def new
    @weight = Weight.new
  end
  
  def create
    @weight = Weight.new(weight_params)
    if @weight.save
      redirect_to weights_path
    else
      render 'new'
    end
  end
  
  def index
    @weights = Weight.order(date: :desc)
  end
  
  def edit
    @weight = Weight.find(params[:id])
  end
  
  def update
    @weight = Weight.find(params[:id])
    if @weight.update_attributes(weight_params)
      flash[:notice] = "Weight Updated"
      redirect_to weights_path
    end
  end
  
  def destroy
    @weight = Weight.find(params[:id])
    @weight.destroy
    redirect_to root_url flash[:notice] = "Weight deleted"
  end
  
  private
  def weight_params
    params.require(:weight).permit(:pounds, :date)
  end
end
