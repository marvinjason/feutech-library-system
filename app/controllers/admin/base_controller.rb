class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  private
  def authorize_user!
    authorized_roles = ['librarian', 'admin'].freeze

    unless authorized_roles.include?(current_user.role)
      redirect_back(fallback_location: root_path)
    end
  end
end
