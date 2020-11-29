class BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @book = @q.result(distinct: true)
    @circle_registers = CircleRegister.where(circle_id: params[:circle_id])
    @circle = Circle.find_by(circle_id: params[:id])
  end

  def show
    @book= Book.find_by(id: params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(
      name: params[:name],
      image_name: "default_user.jpg",
      lend: 0 ,
      circle_id: @current_circle.id
      )
    
    if @book.save
      flash[:notice] = "蔵書登録が完了しました"
      redirect_to("/books/#{@current_circle.id}/index")
    else
      render("books/#{@current_circle.id}/new")
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end
  
  def update
    @book = Book.find_by(id: params[:id])
    @book.name = params[:name]

    if params[:image]
      @book.image_name = "#{@book.id}.jpg"
      image = params[:image]
      File.binwrite("public/book_images/#{@book.image_name}", image.read)
    end

    if @book.save
      flash[:notice] = "蔵書の情報を編集しました"
      redirect_to("/books/#{@current_circle.id}/#{@book.id}")
    else
      render("/books/#{@current_circle.id}/edit")
    end
  end

  def lend
    @book = Book.find_by(id: params[:id])
    
  end

  def lending
    @book = Book.find_by(id: params[:id])
    @book.lend_user_id = @current_user.id
    @book.return_date = params[:date]
    @book.lend = 1

    if @book.save
      flash[:notice] = "貸出しました"
      redirect_to("/books/#{@current_circle.id}/index")
    else 
      # renderメソッドを用いて、editアクションを経由せず、posts/edit.html.erbが表示されるようにしてください
      render("books/#{@current_circle.id}/#{@book.id}/lend")
    end  
  end

  def return_book
    @book = Book.find_by(id: params[:id])
    @book.lend = 0

      @book.save
      flash[:notice] = "返却しました"
      redirect_to("/books/#{@current_circle.id}/index")

    
  end

  def remove_book
    @book = Book.find_by(id: params[:id])
    @book.destroy
    flash[:notice] ="削除しました"
    redirect_to("/books/index")
  end

end
