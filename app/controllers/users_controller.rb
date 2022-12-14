class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @users = User.all
  end
  def new
    @book = Book.new
  end
  def create
    @book = Book.new(book_params)
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
  # showアクション
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  # Editアクション：済
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    # 更新に成功したときの処理
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end
end
