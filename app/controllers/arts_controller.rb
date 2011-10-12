class ArtsController < ApplicationController
  def show
    @art = Art.where(:slug => params[:slug]).first
    @comments = @art.artcomments
    if @art.user != current_user
      if request.env['HTTP_REFERER'].nil? == true
        referrer = "-"
      else
        referrer = request.env['HTTP_REFERER']
      end
      Resque.enqueue(VisitNew, referrer, @art.class.to_s, @art.id.to_s, current_user.id.to_s)
    end
    @title = t("users.index.title")
    render :layout => 'main'
  end

  def user_art_show
    @user = User.where(:username => params[:username]).first
    @arts = @user.arts.page(params[:page]).per(30)
    @title = t("users.index.title")
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

  def index
    @arts = current_user.arts.page(params[:page]).per(30)
    @title = t("arts.index.title")
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

end
