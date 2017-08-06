class CompetitionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @competition = Competition.find(params[:id])
    unless @competition.users.include?(current_user)
      flash[:alert] = "You are not a member of this competition"
      redirect_to competitions_path
    end
  end

  def index
    @competitions = current_user.competitions
  end

  def new
    @competition = Competition.new(end_date: Time.current + 6.weeks)
  end

  def create
    @competition = Competition.new(competition_params)
    @competition.host = current_user
    @competition.users << current_user
    if @competition.save
      redirect_to @competition
    else
      flash[:alert] = "Error.  Please try again"
      render new_competition_path
    end
  end

  def edit
    @competition = Competition.find(params[:id])
    unless @competition.host = current_user
      flash[:alert] = "You must be the host to edit this competition"
      redirect_to competitions_path
    end
  end


  def description
    @competition = Competition.find(params[:competition_id])
  end

  def join
    @competition = Competition.find(params[:competition_id])
    if @competition.users.include?(current_user)
      flash[:alert] = "You are already a member of this competition"
    else
      @competition.users << current_user
    end
    redirect_to @competition
  end

  private
  def competition_params
    params.require(:competition).permit(:start_date, :end_date)
  end
end
