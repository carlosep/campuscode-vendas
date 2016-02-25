class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :user_admin, only: [:new, :create, :index]

  def index
    @users = User.where('is_admin = ? OR is_admin IS ?', false, nil)
  end

  def show
    @user = User.find(params[:id])
    unless current_user.is_admin? || current_user.id == @user.id
      redirect_to root_path, notice: 'Você não é o administrador'
    end
  end

  def new
    @user = User.new
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
          .permit(:name, :email, :password, :is_admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
