class BooksController < ApplicationController
    before_action :authenticate_user!

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
            redirect_to book_path(book)
            return
        else
            @book = book   
            @books = Book.all
            render 'index'
            return
        end
    end

    def update
        book = Book.find(params[:id])
        book.update(book_params)
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
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :opinion)
    end

end
