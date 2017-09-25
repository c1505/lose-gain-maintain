class GoalsController < ApplicationController
  before_action :authenticate_user!
  def new
    @goal = Goal.new
  end
  
  def edit
    @goal = Goal.find(params[:id])
    redirect_to root_path unless current_user == @goal.user
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to @goal
    else
      render @goal
    end
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to @goal
    else
      render @goal
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def index
    @goals = current_user.goals
  end
  
  private
  def goal_params
    params.require(:goal).permit(:weight, :start_date, :target_date, :tolerence_above, :tolerence_below)
  end
end
