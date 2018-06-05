class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :resolve_layout

  private
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
