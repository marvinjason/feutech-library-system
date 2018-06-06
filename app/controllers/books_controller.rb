class BooksController < ApplicationController
  before_action :authenticate_user!, only: :reserve

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
        @reviews.sum(:rating) / @reviews.count
      rescue
        0
      end
  end

  def reserve
    book = Book.find(params[:id])

    Reservation.create!(
      book: book,
      user: current_user
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
end
