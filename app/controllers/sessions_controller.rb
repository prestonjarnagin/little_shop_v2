class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to profile_path, notice: "You are already logged in"
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user == nil
      redirect_to login_path, notice: "Could not log in. Please try again."
    elsif user.active == false
      redirect_to login_path, notice: "Your account has been compromised, please contact Admin"
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path, notice: "You have successfully logged in"
    elsif user
      redirect_to login_path, notice: "Password does not match username. Please try again."
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    redirect_to root_path, notice: "You have successfully logged out"
  end
end
