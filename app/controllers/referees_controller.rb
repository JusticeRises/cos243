class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy, :edit]
  before_action :ensure_owner_is_a_bro, only: [:update , :destroy, :edit]
  before_action :ensure_contest_creator, only: [:edit , :update , :create , :new]
  before_action :referee_retrieve, only: [:show, :edit, :destroy, :update]
  
  def new
    @referee = current_user.referees.build
  end
  
  def create
    @referee = current_user.referees.build(acceptable_params)
    if @referee.save
      flash[:success] = "Referee created: A Referee [" + @referee.name + "] has been spawned in the void."
      redirect_to @referee
    else
      render 'new'
    end
  end
  
  def show
      @referee = Referee.find(params[:id])
  end
  
  def edit
    
  end
  
  def update
    @referee = Referee.find(params[:id])
    if @referee.update(acceptable_params)
      flash[:success] = "The #{@referee.name} referee spawn has been done updated successfully"
      redirect_to @referee
    else
      flash.now[:danger] = "Unable to update #{@referee.name}"
      render 'edit'
    end
  end
  
  def index
    @referees = Referee.all
  end
  
  def destroy
     @referee = Referee.find(params[:id])
     flash[:success] = "Done did obliterated that referee. Dawg, I'm a boss."
     @referee.destroy
     redirect_to "/referees"
  end
  
 private
    
    def acceptable_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
    
    #Alex
    def ensure_contest_creator
      (redirect_to root_path and flash[:danger] = "You are not a contest creator") unless current_user.contest_creator
    end
  
    def ensure_owner_is_a_bro
      @referee = referee_retrieve
      (flash[:danger] = "You are not the correct user" and redirect_to root_path) unless owner?(@referee)
    end
  
    def ensure_admin
      redirect_to root_path unless current_user.admin?
    end

  def referee_retrieve
      @referee = Referee.find(params[:id])
    end
end
