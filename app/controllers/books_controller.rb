class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :user_check, only: %i[edit update destroy]


    def index
        @books = Book.all
        @user = current_user
        @book = Book.new
    end

    def new
    end

    def create
        book = Book.new(book_params)
        book.user_id = current_user.id
        @user = current_user

        if book.save
            flash[:notice] = 'successfully.'
            redirect_to book_path(book)
            return
        else
            flash[:error] = 'error.'
            @book = book   
            @books = Book.all
            render 'index'
            return
        end
    end

    def update
        book = Book.find(params[:id])
        if book.update(book_params)
            flash[:notice] = 'successfully.'
        else
            flash[:error] = 'error.'
        end
        redirect_to book_path(book)
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
    end
    
    def edit
        @book = Book.find(params[:id])
    end

    def destroy
        book = Book.find(params[:id])
        book.destroy
        flash[:notice] = 'successfully.'
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end

    def user_check
        @book = Book.find(params[:id])
        # 自分以外の場合はリダイレクト
        if current_user.id != @book.user_id
            redirect_to books_path
            return
        end
    end

end
