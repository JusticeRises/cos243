module SessionsHelper
  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def logged_in?
    !current_user.nil?
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
end
