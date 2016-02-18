class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  layout :login_layout

  protected

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
