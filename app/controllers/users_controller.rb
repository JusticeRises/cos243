class UsersController < ApplicationController
    
	def new
        @user = User.new
  end
  
  def create
    #@user = User.new(:username => params[:username],:password => params[:password])
    #render 'new'
    
    #Why does this not work?
    #@user = User.new(params[:user])
    #@user.save
    
    permitted_params = params.require(:user).permit(:username, :password, :password_confirmation)
		@user = User.new(permitted_params)
		if @user.save then
			redirect_to @user #type of response that the server can give to the browser.
		else
			render 'new'
		end
  end
end
