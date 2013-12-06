class ContestsController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy, :edit]
  before_action :ensure_contest_creator, only: [:edit , :update , :create , :new, :destroy]
  before_action :ensure_owner_is_a_bro, only: [:update , :destroy, :edit]
  before_action :contest_retrieve, only: [:show, :edit, :destroy, :update]
  
  def new
    @contest = current_user.contests.build
  end
  
  def index
    @contests= Contest.all
  end
  
  def edit
  end
  
  def destroy
    @contest = Contest.find(params[:id])
    flash[:success] = "Done did obliterated that contest. Dawg, I'm a boss."
    @contest.destroy
    redirect_to "/contests"
  end
  
  def create
    @contest = current_user.contests.build(acceptable_params)
    #@contest.referee = Referee.find(params[:contest][:referee_id])
    if @contest.save
      flash[:success] = "Congrats, that dere contest was made. Go make yourself a sandwich or something. Contest created"
      redirect_to @contest
    else
      flash[:danger] = "Your contest was rejected.  It's not you, it's me. Honest."
      render :new
    end
  end
  
  def show
    @contest = Contest.find(params[:id])
  end

  def update
    @contest = Contest.find(params[:id])
    
    if @contest.update(acceptable_params)
      flash[:success] = "The #{@contest.name} has been updated successfully (yo)."
      redirect_to @contest
    else
      flash.now[:danger] = "Unable to update #{@contest.name}"
      render 'edit'
    end
  end 
  
  private
    def acceptable_params
      params.require(:contest).permit(:deadline, :start, :description, :name, :contest_type, :referee_id)
    end
  
    def ensure_owner_is_a_bro
      @contest = contest_retrieve
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@contest)
    end
  
    def ensure_contest_creator
      (flash[:danger] = "You do not currently have the permission granted to those who can perform the permissible action of which you attempted to achieve." and redirect_to root_path) unless current_user.contest_creator?
    end
  #Alex
  
    def contest_retrieve
      @contest = Contest.find(params[:id])
    end
end
