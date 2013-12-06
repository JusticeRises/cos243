class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_user_not_logged_in, only: [:create, :new]
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :ensure_admin, only: [:destroy]
  
  respond_to :html, :json, :xml
  
  def index
    @users =User.all
    respond_with(@users)
  end
  
  def edit
    respond_with(@user)
  end
  

  
	def new
    @user = User.new
    respond_with(@user)
  end
  
  
  
  def create
    #@user = User.new(:username => params[:username],:password => params[:password])
    #render 'new'
    
    #Why does this not work?
    #@user = User.new(params[:user])
    #@user.save
    
    @user = User.new(acceptable_params)
		if @user.save then
      sign_in @user
      cookies.signed[:user_id] = @user.id
      flash[:success] = "Welcome to the site: #{@user.username}! You have officially unofficially logged in!"
		end
    respond_with(@user)
      
  end
    
  def show
    @user = User.find(params[:id])
   respond_with(@user)
  end
    
    
  def update
    @user = User.find(params[:id])
    if @user.update(acceptable_params)
      flash[:success] = "Your profile has been updated: #{@user.username}"
    else
      flash.now[:danger] = "Unable to update #{@user.username}"
    end
    respond_with(@user)
  end
  
    
  def destroy
    @user =  User.find(params[:id])
    if( @user.admin)
      flash[:danger] = "That's an admin, what you thinking foo?"
    elsif(current_user.admin)
      @user.destroy
      flash[:success] = "User deleted. Now sit in a corner and think about what you've done."
    else
      flash[:danger] = "Your not an admin... imposter!!"
    end
    respond_with(@user)
  end
    
  private
    
    def acceptable_params
      acceptable_params = params.require(:user).permit(:username, 
                                                       :password,
                                                       :password_confirmation,
                                                       :email)
    end
    
    def ensure_user_not_logged_in
      if (logged_in?)
        flash[:warning] = "There is an error in our midst bro"
        redirect_to "/"
      end
    end
    
    def ensure_current_user
      @user = User.find(params[:id])
      (redirect_to "/" and flash[:danger] = "Error yo") unless current_user?(@user)
    end
    
    def ensure_admin
      (redirect_to root_path and flash[:danger] = "You are not an admin") unless current_user.admin?
    end
    
    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end  
    
    
end
