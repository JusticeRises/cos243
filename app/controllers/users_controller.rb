class UsersController < ApplicationController
   
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
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
      
  end
    
  def show
    @user = User.find(params[:id])
    ##@microposts = @user.microposts.paginate(page: params[:page])
  end
    
    
    def update
    @user = User.find(params[:id])
    if @user.update(acceptable_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end  
    
    
  private
    
    def acceptable_params
      acceptable_params = params.require(:user).permit(:username, 
                                                       :password, 
                                                       :password_confirmation,
                                                       :email)
    end
end
