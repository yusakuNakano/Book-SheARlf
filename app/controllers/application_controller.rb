class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :set_current_circle
    
  
  # set_current_userメソッドを定義してください
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def set_current_circle
    @current_circle = Circle.find_by(id: session[:circle_id])
  end

  

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbid_login_user
    if @current_user && @current_circle
      session[:user_id] = nil
      session[:circle_id]
      flash[:notice] = "ログアウトしました"
      redirect_to("/login")
      
    end

  
  end

  
end
