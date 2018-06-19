class BooksController < ApplicationController
  before_action :store_location_for_review, only: :review
  before_action :authenticate_user!, only: [:reserve, :review]
  before_action :guard_reserve, only: [:reserve]

  def featured
    @books =
      Book.all.sort do |a, b|
        a.reviews.sum(&:rating) <=> b.reviews.sum(&:rating)
      end.reverse.first(5)
  end

  def index
    if request.post?
      column = params[:column]
      search_term = params[:search]

      if search_term.blank?
        @books = Book.order(created_at: :desc)
      else
        @books = Book.where("#{column} = ?", search_term)
                     .order(created_at: :desc)
      end
    else
      @books = Book.order(created_at: :desc)
    end

    @books = @books.page(params[:page])
    @page_count = @books.total_pages
    @current_page = @books.current_page
    @previous_page = @books.prev_page
    @next_page = @books.next_page
  end

  def search
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
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @comments = @book.comments.where(comment_id: nil)

    @authors_link =
      @book.authors.map do |author|
        "<a href='#{author_path(author)}' class='no-margin author'>#{author.first_name} #{author.last_name}</a>"
      end

    @score =
      begin
        (@reviews.sum(:rating) / @reviews.count.to_f).round
      rescue
        0
      end
  end

  def reserve
    book = Book.find(params[:id])

    reservation = Reservation.create!(
      book: book,
      user: current_user,
      start: params[:from],
      end: params[:to]
    )

    Log.create(
      user: current_user,
      logable: reservation,
      log_type: 'reservation'
    )

    flash[:success] = {
      header: t('.success.header'),
      body: t('.success.body')
    }
  rescue
    flash[:negative] = {
      header: t('.error.header'),
      body: t('.error.body')
    }
  ensure
    redirect_to action: :show
  end

  def review
    book = Book.find(params[:id])

    Review.create!(
      book: book,
      user: current_user,
      rating: params[:rating],
      body: params[:body]
    )

    flash[:success] = {
      header: t('.success.header'),
      body: t('.success.body')
    }
  rescue
    flash[:negative] = {
      header: t('.error.header'),
      body: t('.error.body')
    }
  ensure
    redirect_to book
  end

  def comment
    book = Book.find(params[:id])

    Comment.create!(
      book: book,
      user: current_user,
      body: params[:body]
    )

    flash[:success] = {
      header: t('.success.header'),
      body: t('.success.body')
    }
  rescue
    flash[:negative] = {
      header: t('.error.header'),
      body: t('.error.body')
    }
  ensure
    redirect_to book
  end

  private
  def store_location_for_review
    book = Book.find(params[:id])
    store_location_for(:user, book_path(book))
  end

  def guard_reserve
    if current_user.role != 'user'
      flash[:negative] = {
        header: t('.error.header'),
        body: t('.error.body')
      }

      redirect_back(fallback_location: root_path)
    end
  end
end
