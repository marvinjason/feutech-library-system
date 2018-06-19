module Admin
  class UsersController < BaseController
    def index
      @users = User.order(:created_at).page(params[:page])
      @page_count = @users.total_pages
      @current_page = @users.current_page
      @previous_page = @users.prev_page
      @next_page = @users.next_page
    end

    def search
      column = params[:column]
      search_term = params[:search]

      if search_term.blank?
        @users = User.order(:created_at)
      else
        @users = User.where("#{column} = ?", search_term)
                         .order(:created_at)
      end

      @users = @users.page(params[:page])
      @page_count = @users.total_pages
      @current_page = @users.current_page
      @previous_page = @users.prev_page
      @next_page = @users.next_page

      render 'admin/users/index'
    end

    def new
      @user = User.new
    end

    def create
      user = User.new(user_params)

      if user.save
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

    def edit
      @user = User.find(params[:id])
    end

    def update
      user = User.find(params[:id])

      if user.update(user_params)
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

    def destroy
      user = User.find(params[:id])

      if user.destroy
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
    def user_params
      params.require(:author).permit(:last_name, :first_name, :description, :avatar)
    end
  end
end
