class CirclesController < ApplicationController
  def index
    @q = Circle.ransack(params[:q])
    @circle = @q.result(distinct: true)
  end

  def show
    @circle = Circle.find_by(id: params[:id])
  end

  def new
    @circle = Circle.new
  end

  def edit
    @circle = Circle.find_by(id: params[:id])
  end

  

  def create
    @circle = Circle.new(
      name: params[:name],
      image_name: "default_circle.jpg",
      )

      if @circle.save
        flash[:notice] = "サークルを新規作成しました"
        redirect_to("/circles/#{@current_circle.id}/index")
      else
        render("circles/new")
      end
  end

  def update
    @circle = Circle.find_by(id: params[:id])
    @circle.name = params[:name]
  
    if params[:image]
      @circle.image_name = "#{@circle.id}.jpg"
      image = params[:image]
      File.binwrite("public/circle_images/#{@circle.image_name}", image.read)
    end
  
    if @circle.save
      flash[:notice] = "蔵書の情報を編集しました"
      redirect_to("/circles/#{@circle.id}")
    else
      render("/circles/edit")
    end
  end

  def remove_circle
    @circle = Circle.find_by(id: params[:id])
    @circle.destroy
    flash[:notice] ="削除しました"
    redirect_to("/circles/index")
  end

  def join_index
    @circle_register = CircleRegister.where(user_id: @current_user.id)
  end

  def change_circle
      session[:circle_id] = params[:circle_id]
      redirect_to("/circles/#{params[:circle_id]}/#{@current_user.id}/join_index")
  end

  def join_circle
    @circle_regist = CircleRegister.new(
      user_id: @current_user.id,
      circle_id: params[:circle_id],
    )
  
   
   
      if @circle_regist.save
        flash[:notice] = "サークルに参加しました"
        redirect_to("/circles/#{@current_circle.id}/index")
      else
        flash[:notice] = "参加済みです"
        redirect_to("/circles/#{@current_circle.id}/index")
      end

  end

  def resign_circle
    @circle_regist = CircleRegister.find_by(
      user_id: @current_user.id,
      circle_id: params[:circle_id],
    )    

    @circle_
  end

end
