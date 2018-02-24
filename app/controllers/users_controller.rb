class UsersController < ApplicationController
  def index
    @users = User.order(:name).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:id)
  end
end
