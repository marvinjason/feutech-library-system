class Admin::BooksController < ApplicationController
  def index
    @books = Book.order(:created_at).page(params[:page])
    @page_count = @books.total_pages
    @current_page = @books.current_page
    @previous_page = @books.prev_page
    @next_page = @books.next_page
  end

  def search
    column = params[:column]
    search_term = params[:search]

    if search_term.blank?
      @books = Book.order(:created_at)
    else
      @books = Book.where("#{column} = ?", search_term)
                       .order(:created_at)
    end

    @books = @books.page(params[:page])
    @page_count = @books.total_pages
    @current_page = @books.current_page
    @previous_page = @books.prev_page
    @next_page = @books.next_page

    render 'admin/books/index'
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)

    if book.save
      flash[:success] = {
        header: t('.success.header'),
        body: t('.success.body')
      }

      redirect_to book
    else
      flash[:negative] = {
        header: t('.success.header'),
        body: t('.success.body')
      }

      redirect_back(fallback_location: root_path)
    end
  end

  private
  def book_params; end
end
