class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private
  def template
    "#{controller_name}/#{action_name}/#{current_user.role}"
  end
end
