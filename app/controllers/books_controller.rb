class BooksController < ApplicationController

  def index
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
  def show
    
  end
end
