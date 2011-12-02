class AdminController < ApplicationController
  
  before_filter :user_admin?
  
  def dashboard
    @users_count = User.count
    @users_today = User.where(:created_at.gte => 1.day.ago.utc).count
    @art_count = Art.count
    @art_today = Art.where(:created_at.gte => 1.day.ago.utc).count
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
    @arts = Art.where(:photo => false).order_by(:created_at, :desc).page(params[:page]).per(30)
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
    @art.status_reason = params[:art][:status_reason]
    if @art.accepted_changed? == true
      accepted_changed = true
    else
      accepted_changed = false
    end
    if @art.save
      Resque.enqueue(FindSimilarArt, @art.id.to_s)
      if accepted_changed == true and @art.accepted == true
        # change the privacy options for show the art to the public
        user = @art.user
        user.privacy.sos = 2
        user.save
        # generates the upa event 'user-published-art'
        data = Hash.new
        data['who'] = @art.user.id.to_s
        data['when'] = Time.now
        data['what'] = "upa"
        data['art'] = @art.id.to_s
        Resque.enqueue(Notificator, data)
      end
      flash[:success] = "Arte actualizado correctamente"
    else
      flash[:error] = "No se ha podido actualizar la obra"
    end
    redirect_to admin_arts_index_path
  end
  
  def photo_index
    @arts = Art.where(:photo => true).order_by(:created_at, :desc).page(params[:page]).per(30)
  end
  
  def photo_edit
    @art = Art.where(:slug=> params[:slug]).first
  end

  def photo_update
    @art = Art.where(:slug => params[:id]).first
    @art.name = params[:art][:name]
    @art.price = params[:art][:price]
    @art.image = params[:art][:image] if params[:art][:image].nil? == false
    @art.max_height = params[:art][:max_height]
    @art.max_width = params[:art][:max_width]
    @art.accepted = params[:art][:accepted]
    @art.status_reason = params[:art][:status_reason]
    if @art.accepted_changed? == true
      accepted_changed = true
    else
      accepted_changed = false
    end
    if @art.save
      Resque.enqueue(FindSimilarArt, @art.id.to_s)
      if accepted_changed == true and @art.accepted == true
        # change the privacy options for show the art to the public
        user = @art.user
        user.privacy.sos = 2
        user.save
        # generates the upa event 'user-published-art'
        data = Hash.new
        data['who'] = @art.user.id.to_s
        data['when'] = Time.now
        data['what'] = "upa"
        data['art'] = @art.id.to_s
        Resque.enqueue(Notificator, data)
      end
      flash[:success] = "Arte actualizado correctamente"
    else
      flash[:error] = "No se ha podido actualizar la obra"
    end
    redirect_to admin_photo_index_path
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
