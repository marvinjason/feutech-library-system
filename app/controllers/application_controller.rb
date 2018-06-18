class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_current_location, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :resolve_layout

  protected
  def after_sign_in_path_for(resource)
    flash.discard
    flash[:success] = 'You have succesfully signed in'
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private
  def store_current_location
    store_location_for(:user, request.url)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :avatar])
  end

  def resolve_layout
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def template
    "#{controller_name}/#{action_name}/#{current_user.role}"
  end
end
