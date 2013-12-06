module SessionsHelper
   def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  
  def contest_creator?
    current_user.contest_creator
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def ensure_user_logged_in
      if (!logged_in?)
        flash[:warning] = "There is an error in our midst"
        redirect_to login_path
      end
  end
   
  def ensure_current_user
      @user = User.find(params[:id])
      (redirect_to "/" and flash[:danger] = "Error yo") unless current_user?(@user)
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
   def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end
  
  
  ##Alex voodoo
  def owner?(thingamawatchit)
    current_user.id == thingamawatchit.user_id
  end
  
  def ensure_contest_creator
      (flash[:danger] = "You aren't allowed to create contests" and redirect_to root_path) unless current_user and current_user.contest_creator?
  end
  
end
