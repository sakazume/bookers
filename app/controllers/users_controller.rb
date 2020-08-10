class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :user_check, only: %i[edit update]

    def index
        @users = User.all
        @user = current_user
        @book = Book.new

    end

    def show
        @user = User.find(params[:id])
        @book = Book.new
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            flash[:notice] = 'successfully.'
        else
            flash[:error] = 'error.'
        end
        redirect_to user_path(user)

    end

    private
    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def user_check
        @user = User.find(params[:id])
        # 自分以外の場合はリダイレクト
        if current_user.id != @user.id
            redirect_to user_path(current_user)
            return
        end
    end
end
