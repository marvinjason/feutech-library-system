class BooksController < ApplicationController
  before_action :store_location_for_review, only: :review
  before_action :authenticate_user!, only: [:reserve, :review]

  def featured
    @books = Book.limit(5)
  end

  def index
    @books = Book.page(params[:page])
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

    Reservation.create!(
      book: book,
      user: current_user,
      start: params[:from],
      end: params[:to]
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

  private
  def store_location_for_review
    book = Book.find(params[:id])
    store_location_for(:user, book_path(book))
  end
end
