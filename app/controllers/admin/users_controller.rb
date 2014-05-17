module Admin
  class UsersController < BaseController
    load_and_authorize_resource :user
    add_breadcrumb 'users', :admin_users_path
    before_filter :add_user_breadcrumb, except: :index

    def index
      respond_with @users
    end

    # Sends recovery instructions to user
    def recover
      @user.send_reset_password_instructions
      flash[:notice] = 'Reset instructions has been send.'
      respond_with @user, location: request.referer
    end

    # TOTO
    def show
      respond_with @user
    end

    def edit
      respond_with @user
    end

    def update
      @user.skip_password_validation = false
      @user.update_attributes(params[:user])
      if @user.valid?
        respond_with @user, location: request.referer
      else
        render :edit
      end
    end

    def new
      respond_with @user
    end

    def create
      @user.skip_password_validation = false
      @user.update_attributes(user_params)
      if @user.valid?
        @user.send_reset_password_instructions
        respond_with @user, location: admin_user_path(@user)
      else
        render :new
      end
    end

    def destroy
      @user.destroy
      respond_with @user, location: request.referer
    end

    private

    def add_user_breadcrumb
      if @user.present?
        if @user.persisted?
          add_breadcrumb @user.humanize
        else
          add_breadcrumb 'new user'
        end
      end
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end
  end
end
