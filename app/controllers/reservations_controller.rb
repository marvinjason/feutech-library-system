class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when 'user'
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
    when 'librarian'
      if request.post?
        column = params[:column]
        search_term = params[:search]

        if search_term.blank?
          @reservations = Reservation.order(:created_at)
        else
          @reservations = Reservation.joins(:book)
                                     .where("#{column} = ?", search_term)
                                     .order(:created_at)
        end
      else
        @reservations = Reservation.order(:created_at)
      end

      @reservations = @reservations.page(params[:page])
      @page_count = @reservations.total_pages
      @current_page = @reservations.current_page
      @previous_page = @reservations.prev_page
      @next_page = @reservations.next_page
    end

    render template
  end

  def approve
    reservation = Reservation.find(params[:id])
    reservation.status = 'approved'

    if reservation.save
      book = reservation.book
      book.update(total_count: book.total_count - 1)

      Log.create(
        user: current_user,
        logable: reservation,
        log_type: 'approval'
      )

      flash[:success] = {
        header: t('.success.header'),
        body: t('.success.body')
      }
    else
      flash[:negative] = {
        header: t('.error.header'),
        body: t('.error.body')
      }
    end

    redirect_back(fallback_location: root_path)
  end

  def reject
    reservation = Reservation.find(params[:id])
    reservation.status = 'rejected'

    if reservation.save
      Log.create(
        user: current_user,
        logable: reservation,
        log_type: 'rejection'
      )

      flash[:success] = {
        header: t('.success.header'),
        body: t('.success.body')
      }
    else
      flash[:negative] = {
        header: t('.error.header'),
        body: t('.error.body')
      }
    end

    redirect_back(fallback_location: root_path)
  end
end
