class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :ensure_admin, only: [:destroy]
  def index
    @users =User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  

  
	def new
    @user = User.new
  end
  
  
  
  def create
    #@user = User.new(:username => params[:username],:password => params[:password])
    #render 'new'
    
    #Why does this not work?
    #@user = User.new(params[:user])
    #@user.save
    
    @user = User.new(acceptable_params)
		if @user.save then
      flash[:success] = "Welcome to the site: #{@user.username}"
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
      
  end
    
  def show
    @user = User.find(params[:id])
 
  end
    
    
  def update
    @user = User.find(params[:id])
    if @user.update(acceptable_params)
      flash[:success] = "Your profile has been updated: #{@user.username}"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
    
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
    
  private
    
    def acceptable_params
      acceptable_params = params.require(:user).permit(:username, 
                                                       :password,
                                                       :password_confirmation,
                                                       :email)
    end
    
    def ensure_user_logged_in
      redirect_to login_path unless logged_in?
    end
    
    def ensure_current_user
      @user = User.find(params[:id])
      redirect_to users_path unless current_user?(@user) 
    end
    
    def ensure_admin
      redirect_to root_path unless cureent_user.admin?
    end
    
    def signed_in_user
      unless logged_in?
        store_location
        redirect_to login_path, notice: "Please sign in."
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
end
