class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @books = Book.all
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      # 投稿成功した場合
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      # 投稿が失敗した場合
      @books=Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # 更新に成功したときの処理
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    @books = Book.find(params[:id])
    user_id = @books.user_id
    # user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end