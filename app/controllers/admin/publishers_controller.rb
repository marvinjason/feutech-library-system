class Admin::PublishersController < ApplicationController
  def index
    @publishers = Publisher.order(:created_at).page(params[:page])
    @page_count = @publishers.total_pages
    @current_page = @publishers.current_page
    @previous_page = @publishers.prev_page
    @next_page = @publishers.next_page
  end

  def search
    column = params[:column]
    search_term = params[:search]

    if search_term.blank?
      @publishers = Publisher.order(:created_at)
    else
      @publishers = Publisher.where("#{column} = ?", search_term)
                       .order(:created_at)
    end

    @publishers = @publishers.page(params[:page])
    @page_count = @publishers.total_pages
    @current_page = @publishers.current_page
    @previous_page = @publishers.prev_page
    @next_page = @publishers.next_page

    render 'admin/publishers/index'
  end

  def new
    @publisher = Publisher.new
  end

  def create
    publisher = Publisher.new(publisher_params)

    if publisher.save
      flash[:success] = {
        header: t('.success.header'),
        body: t('.success.body')
      }

      redirect_to action: :index
    else
      flash[:negative] = {
        header: t('.success.header'),
        body: t('.success.body')
      }

      redirect_back(fallback_location: root_path)
    end
  end

  private
  def publisher_params
    params.require(:publisher).permit(:name)
  end
end
