class AdminController < ApplicationController
  
  before_filter :user_admin?
  
  def dashboard
    @users_count = User.count
    @users_today = User.where(:created_at.gte => 1.day.ago).count
    @art_count = Art.count
    @art_today = Art.where(:created_at.gte => 1.day.ago).count
    render :layout => 'admin'
  end

  def users_index
    @users = User.order_by(:created_at, :desc).page(params[:page]).per(30)    
  end

  def user_edit
    @user = User.where(:username => params[:username]).first
  end

  def user_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuario actualizado correctamente"
    else
      flash[:error] = "No se ha podido actualizar el usuario"
    end
    redirect_to admin_users_index_path
  end
  
  def arts_index
    @arts = Art.order_by(:created_at, :desc).page(params[:page]).per(30)
  end
  
  def art_edit
    @art = Art.where(:slug=> params[:slug]).first
  end

  def art_update
    @art = Art.where(:slug => params[:id]).first
    @art.name = params[:art][:name]
    @art.price = params[:art][:price]
    @art.image = params[:art][:image] if params[:art][:image].nil? == false
    @art.max_height = params[:art][:max_height]
    @art.max_width = params[:art][:max_width]
    @art.accepted = params[:art][:accepted]
    if @art.save
      Resque.enqueue(FindSimilarArt, @art.id.to_s)
      Resque.enqueue(ColorsFromImage, @art.id.to_s)
      flash[:success] = "Arte actualizado correctamente"
    else
      flash[:error] = "No se ha podido actualizar la obra"
    end
    redirect_to admin_arts_index_path
  end
  
  private
  
  def user_admin?
    if current_user.nil? == true 
      redirect_to :not_found
    else
      if current_user.is_admin? == false
        redirect_to :not_found
      end
    end
  end

end
