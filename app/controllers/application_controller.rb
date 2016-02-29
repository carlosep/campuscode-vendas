require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  layout :login_layout

  respond_to :html

  protected

  def user_admin
    unless current_user.is_admin?
      flash[:notice] = 'Você não é o administrador'
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def login_layout
    if current_user
      'application'
    else
      'login'
    end
  end
end
