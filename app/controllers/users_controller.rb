class UsersController < ApplicationController
  def new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
  end

  private
  # Strong params ftw?
  # Need a better grasp at this
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
