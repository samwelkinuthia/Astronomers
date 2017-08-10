class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      login(user)
      redirect_back fallback_location: new_session_path, notice; 'logged_in'
    else
      flash.now[:notice] = 'Password and Username Do not match. Try Again'
      render new
    end
  end

  def destroy
    logout
    redirect_back fallback_location: new_session_path, :notice: 'Logged Out'
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end
