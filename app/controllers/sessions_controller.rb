class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
      # log the user in and redirect the user to their show page
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
