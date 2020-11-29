class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @circle_registers = CircleRegister.where(circle_id: params[:circle_id])
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def index_manager
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpg",
      # params[:password]をnewメソッドの引数に追加してください
      password: params[:password]
      
    )

      if @user.save
        # 登録されたユーザーのidを変数sessionに代入してください
        session[:user_id] = @user.id
      else
        render("users/new")
      end

      @circle = Circle.new(
        name: "MyCircle",
        image_name: "default_circle.jpg",
        my_circle: true,
        make_user_id: @user.id
        )

        if @circle.save
        else
          render("users/new")
        end

    @circle_register = CircleRegister.new(
      user_id:@user.id, 
      circle_id:@circle.id)
    
    if @circle_register.save
      session[:user_id] = @user.id
      session[:circle_id] = @circle.id
      redirect_to("/users/#{@circle.id}/index")
      flash[:notice] = "ユーザー登録が完了しました"
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def remove_user
    @user = User.find_by(id: params[:id])
    if @current_user.id == @user.id
      @user.destroy
      flash[:notice] = "削除しました"
      redirect_to("signup")
    else
      @user.destroy
      flash[:notice] ="削除しました"
      redirect_to("/users/index_manager")
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @circle = Circle.find_by(id: params[:circle_id])

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@circle.id}/#{@user.id}")
    else
      render("users/#{@circle.id}/#{@user.id}/edit")
    end
  end

  def login_form

  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @circle = Circle.find_by(make_user_id: @user.id,  my_circle: true)
      session[:user_id] = @user.id
      session[:circle_id] = @circle.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@circle.id}/index")
    else
      # @error_messageを定義してください
      @error_message = "メールアドレスまたはパスワードが間違っています"
      
      # @emailと@passwordを定義してください
      @email = params[:email]
      @password = params[:password]
      
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    session[:circle_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def likes
    # 変数@userを定義してください
    @user = User.find_by(id: params[:id])
    
    # 変数@likesを定義してください
    @likes = Like.where(user_id: @user.id)
    @circle = Circle.find_by(id: params[:circle_id])
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
