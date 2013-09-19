class UsersController < ApplicationController
	def new
    @user = User.new
  end
  
  def create
    @user = User.new(:username => params[:username],:password => params[:password])
    render 'new'
    
    #Why does this not work?
    #@user = User.new(params[:user])
    #@user.save
  end
  
  
  
end
