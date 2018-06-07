class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'user'
      if request.post?
        column = params[:column]
        search_term = params[:search]

        if search_term.blank?
          @reservations = current_user.reservations
                                      .order(:created_at)
        else
          @reservations = current_user.reservations
                                      .joins(:book)
                                      .where("#{column} = ?", search_term)
                                      .order(:created_at)
        end
      else
        @reservations = current_user.reservations
                                    .order(:created_at)
      end

      @reservations = @reservations.page(params[:page])
      @page_count = @reservations.total_pages
      @current_page = @reservations.current_page
      @previous_page = @reservations.prev_page
      @next_page = @reservations.next_page
    end

    render template
  end
end
