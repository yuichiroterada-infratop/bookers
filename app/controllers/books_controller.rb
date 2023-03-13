class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

  def index
    @books = Book.all.order(id: :asc)
    @book = Book.new  #<-ここに書いちゃうことで解決！
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book has been successfully created!"
      redirect_to book_path(@book.id)
    else
      @books = Book.all.order(id: :asc)
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book has been successfully updated!"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
