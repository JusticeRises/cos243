class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :ensure_admin, only: [:destroy]
  
  def new
    @referee = current_user.referees.build
  end
  
  def create
    @referee = current_user.referees.build(acceptable_params)
    if @referee.save
      flash[:success] = "A Referee [" + @referee.name + "] has been spawned in the void."
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
    @referee = Referee.all
  end
  
  def destroy
    
  end
  
 private
    
    def acceptable_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
  
    def ensure_current_user
      @user = User.find(params[:id])
      (redirect_to "/" and flash[:danger] = "Error yo") unless current_user?(@user)
    end
  
    def ensure_admin
      redirect_to root_path unless current_user.admin?
    end
end
