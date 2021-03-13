class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_or_initialize_by(user_param)
    if user.save
      session[:current_user_id] = user.id
      redirect_to topics_path
    else
      render :new
    end
  end

  private

  def user_param
    params.require(:user).permit(:username)
  end
end
