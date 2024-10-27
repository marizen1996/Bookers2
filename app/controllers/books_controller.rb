class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)

    else
      flash.now[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @books = Book.all
    @user =  current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)
  end

   def destroy
     book = Book.find(params[:id])
     book.destroy
     redirect_to '/books'
   end


    private
 def book_params
   params.require(:book).permit(:title, :body ,:profile_image)
 end

 def is_matching_login_user
    book = Book.find(params[:id])
    if(book.user != current_user)
      redirect_to books_path
    end
 end

end
