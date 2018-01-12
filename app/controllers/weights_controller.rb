class WeightsController < ApplicationController
  before_action :authenticate_user!
  def new
    @weight = Weight.new
  end
  
  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
    if @weight.save
      flash[:notice] = "Weight Saved"
      redirect_to weights_path
    else
      flash[:notice] = "There was an error.  Please try again"
      render 'new' 
    end
  end
  
  def index
    if params[:months]
      months = params[:months].to_i
      date = Time.now - months.month
      @weights = current_user.weights.where( date: (date..(Time.now.end_of_day + 1.day )) ).order(date: :desc)
    else
      @weights = current_user.weights.order(date: :desc)
    end
    respond_to do |format|
      format.html
      format.json { render :json => {:weights => @weights } }
      format.csv { send_data @weights.to_csv, filename: "weights=#{Date.today}.csv" }
    end
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
    redirect_to root_url flash[:alert] = "Weight deleted"
  end
  
  private
  def weight_params
    params.require(:weight).permit(:pounds, :date)
  end
end
