class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', alert: "Unable to login. Please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
