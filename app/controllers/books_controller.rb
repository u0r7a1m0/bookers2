class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      # 投稿成功した場合
      flash[:success]="Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # 投稿が失敗した場合
      @books=Book.all
      render :show
    end
  end
  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end
  # def user_params
  #   params.require(:user).permit(:name, :profile_image, :introduction)
  # end
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
