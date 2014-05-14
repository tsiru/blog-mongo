module Admin
  class UsersController < BaseController
    load_and_authorize_resource :user
    add_breadcrumb 'użytkownicy', :admin_users_path

    def index
      respond_with @users
    end

    def show
      respond_with @user
    end

    def edit
      add_breadcrumb @user.humanize, edit_admin_user_path(@user)
      respond_with @user
    end

    def new
      add_breadcrumb 'new user', admin_users_path
      respond_with @user
    end

    def create
      respond_with @user
    end

    def update
      @user.update_attributes(params[:user])
      respond_with @user, location: edit_admin_user_path(@user)
    end

    def destroy
      @user.destroy
      respond_with @user, location: admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
  end
end
