class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user,{only:[:edit, :update, :destroy]}
  def index
    # @posts = Post.all.order(created_at: :desc)
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
    @circle_registers = CircleRegister.where(circle_id: params[:circle_id])
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user_rb
    # 変数@likes_countを定義してください
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    @circle = Circle.find_by(id: params[:circle_id])
    if @post.save
      flash[:notice] ="作成しました"
      redirect_to("/posts/#{@circle.id}/index")
    else
      render("posts/#{@circle.id}/new")
    end
  end

  def edit
    # 変数@postを定義してください
    @post = Post.find_by(id: params[:id])
  end

  def update
     # updateアクションの中身を作成してください
     @post = Post.find_by(id: params[:id])
     @post.content = params[:content]
     @circle = Circle.find_by(id: params[:circle_id])
     if @post.save
      flash[:notice] = "編集しました"
      redirect_to("/posts/#{@circle.id}/index")
      else 
      # renderメソッドを用いて、editアクションを経由せず、posts/edit.html.erbが表示されるようにしてください
      render("posts/#{@circle.id}/#{@post.id}/edit")
      end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] ="削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません" 
      redirect_to("/posts/index")
    end
  end

end
