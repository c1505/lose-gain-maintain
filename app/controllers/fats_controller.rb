class FatsController < ApplicationController
  before_action :authenticate_user!
  def index
    @fats = current_user.fats.order(date: :desc)
  end
  
  def new
    @fat = Fat.new
  end
  
  def edit
    @fat = Fat.find(params[:id])
  end
  
  def update
    @fat = Fat.find(params[:id])
    if @fat.update_attributes(fat_params)
      redirect_to fats_path
    else
      render @fat
    end
  end
  
  def create
    @fat = Fat.new(fat_params)
    @fat.user = current_user
    if @fat.save
      redirect_to fats_path
    else
      render @fat
    end
  end
  
  private
  def fat_params
    params.require(:fat).permit(:skinfold, :percentage, :date)
  end
  
end
