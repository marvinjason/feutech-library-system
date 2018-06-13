class Admin::AuthorsController < ApplicationController
  def index
    @authors = Author.order(:created_at).page(params[:page])
    @page_count = @authors.total_pages
    @current_page = @authors.current_page
    @previous_page = @authors.prev_page
    @next_page = @authors.next_page
  end

  def search
    column = params[:column]
    search_term = params[:search]

    if search_term.blank?
      @authors = Author.order(:created_at)
    else
      @authors = Author.where("#{column} = ?", search_term)
                       .order(:created_at)
    end

    @authors = @authors.page(params[:page])
    @page_count = @authors.total_pages
    @current_page = @authors.current_page
    @previous_page = @authors.prev_page
    @next_page = @authors.next_page

    render 'admin/authors/index'
  end

  def new
    @author = Author.new
  end

  def create
    author = Author.new(author_params)

    if author.save
      flash[:success] = {
        header: t('.success.header'),
        body: t('.success.body')
      }

      redirect_to action: :index
    else
      flash[:negative] = {
        header: t('.error.header'),
        body: t('.error.body')
      }

      redirect_back(fallback_location: root_path)
    end
  end

  private
  def author_params
    params.require(:author).permit(:last_name, :first_name, :description, :avatar)
  end
end
