class BooksController < ApplicationController
  def featured
    @books = Book.limit(5)
  end

  def index
    @books = Book.page(params[:page])
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @comments = @book.comments
  end
end
