class SessionsController < ApplicationController
  def new
    logged_in_notice if logged_in?
  end

  def create
    user = User.find_by(email: params[:ss][:email])

    if user&.authenticate(params[:ss][:password])
      # redirect_to .
      log_in(user)
      flash[:success] = "Sign in successful. Welcome #{user.name}"
      redirect_to user
    else
      flash.now[:danger] = 'Email and password dont match or doesnt even exists'
      render :new
    end
  end

  def destroy
  end
end
