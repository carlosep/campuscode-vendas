class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :user_admin

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.create(user_params)
    @user.password = 'campuscode'
    @user.save
    respond_with @user
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
