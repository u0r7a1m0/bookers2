class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  def create
    @book = Book.new(book_params)
    if @book.save
    # 投稿成功した場合
    flash[:success]="Book was successfully created."
    redirect_to book_path(@book.id)
    else
    # 投稿が失敗した場合
    @books=Book.all
    render :index
    end
  end
  # showアクション：済
  def show
    @book = Book.new
    @user = User.find(params[:id])
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
  #
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user)
    end
  end
end
