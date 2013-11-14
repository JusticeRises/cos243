class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_user_not_logged_in, only: [:create, :new]
  before_action :ensure_current_user, only: [:edit, :update]
  before_action :ensure_admin, only: [:destroy]
  
  
  def index
    @users =User.all
  end
  
  def edit
    
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
      sign_in @user
      cookies.signed[:user_id] = @user.id
      flash[:success] = "Welcome to the site: #{@user.username}! You have officially unofficially logged in!"
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
      flash.now[:danger] = "Unable to update #{@user.username}"
      render 'edit'
    end
  end
  
    
  def destroy
    @user =  User.find(params[:id])
    if( @user.admin)
      flash[:danger] = "That's an admin, what you thinking foo?"
      redirect_to "/"
    elsif(current_user.admin)
      @user.destroy
      flash[:success] = "User deleted. Now sit in a corner and think about what you've done."
      redirect_to "/users"
    else
      flash[:danger] = "Your not an admin... imposter!!"
      redirect_to "/"
    end
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
      redirect_to root_path unless current_user.admin?
    end
    
    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end  
    
    
end
