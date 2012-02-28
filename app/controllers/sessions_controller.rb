class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_user_name params[:user_name]
    if user.present?
      if user.password == params[:password]
        session[:current_user_id] = user.id
        redirect_to articles_url, :notice => "Welcome, #{user.name}"
      else
        redirect_to new_session_url, :notice => "Sorry that User Name/Password is Incorrect"    
      end
    else
      redirect_to new_session_url, :notice => "Sorry that User Name/Passowrd is Incorrect"
    end
  end
  
  def logout
    reset_session
    redirect_to new_session_url
  end


end

