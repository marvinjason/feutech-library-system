class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @reservations = current_user.logs.where(log_type: 'reservation').order(created_at: :desc)
    @approvals = Log.where(log_type: 'approval').select { |l| l.logable.user == current_user }
    @logs = @reservations + @approvals
    @logs = @logs.sort { |a, b| a.created_at <=> b.created_at }.reverse

    render template
  end
end
