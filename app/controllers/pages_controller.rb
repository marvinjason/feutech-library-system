class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    render template
  end
end
