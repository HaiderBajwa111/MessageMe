class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  def new
  end
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id 
      flash[:notice] = "You are logged in"
      redirect_to root_path
    else
      flash.now[:alert] = "Something went wronge in your credentials"
      render 'new'
    end
  end

  def destroy
    session[user_id] = nil
    flash[:notice] = "logged out"
    redirect_to login_path
  end
  private 
  def logged_in_redirect
    if logged_in?
      flash[:alert] = "You are already logged in"
      redirect_to root_path
    end
  end
end