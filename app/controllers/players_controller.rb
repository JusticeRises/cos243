class PlayersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy, :edit]
  before_action :ensure_owner_is_a_bro, only: [:update , :destroy, :edit]
  before_action :player_retrieve, only: [:show, :edit, :destroy, :update]
  
  def index
    @players =Player.all
  end
  
  def edit
    
  end
  

  # /contests/:contest_id/players/new
	def new
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build
  end
  
  
  # /contests/:contest_id/players
  def create
    contest = Contest.find(params[:contest_id])
    @player = contest.players.build(acceptable_params)
    @player.user = current_user
    if @player.save
      flash[:success] = "Player created"
      redirect_to @player
    else
      flash[:danger] = "Poor rejected player.  You done messed up with that one."
      render :new
    end
  end
    
  def show
  end
    
    
  def update
    
    if @player.update(acceptable_params)
      flash[:success] = "Your profile has been updated: #{@player.name}"
      redirect_to @player
    else
      flash.now[:danger] = "Unable to update #{@player.name}"
      render 'edit'
    end
  end
  
    
  def destroy
    
    flash[:success] = "That's another player we will never have to worry about becoming sentient, taking over, and whatnot... so thanks for that."
    @player.destroy
    redirect_to contest_players_path(@player.contest)
  end
  
  private
  
    def acceptable_params
      params.require(:player).permit( :upload, :description, :name, :downloadable, :playable)
    end
  
    def ensure_owner_is_a_bro
      @player = player_retrieve
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@player)
    end
  
    def player_retrieve
      @player = Player.find(params[:id])
    end
end
