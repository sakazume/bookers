class UsersController < ApplicationController
    before_action :authenticate_user!

    def index
        @users = User.all
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
        user.update(user_params)
        'You have updated user successfully.'
        redirect_to user_path(user)
    end

    private
    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
