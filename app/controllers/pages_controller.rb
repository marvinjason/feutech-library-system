class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    case current_user.role
    when 'user'
      reservations = current_user.logs.where(log_type: 'reservation').order(created_at: :desc)
      approvals = Log.where(log_type: 'approval').select { |l| l.logable.user == current_user }
      rejections = Log.where(log_type: 'rejection').select { |l| l.logable.user == current_user }
      @logs = order_chronologically(reservations + approvals + rejections)
    when 'librarian'
      reservations = Log.where(log_type: 'reservation').order(created_at: :desc)
      approvals = Log.where(log_type: 'approval').order(created_at: :desc)
      rejections = Log.where(log_type: 'rejection').order(created_at: :desc)
      @logs = order_chronologically(reservations + approvals + rejections)
    when 'admin'
    end

    render template
  end

  private
  def order_chronologically(logs)
    logs.sort { |a, b| a.created_at <=> b.created_at }.reverse
  end
end
