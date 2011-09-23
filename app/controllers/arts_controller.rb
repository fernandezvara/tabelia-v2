class ArtsController < ApplicationController
  def show
    @art = Art.where(:slug => params[:slug]).first
    @title = t("users.index.title")
    render :layout => 'main'
  end

  def user_art_show
    @user = User.where(:username => params[:username]).first
    @arts = @user.arts.page(params[:page]).per(30)
    @title = t("users.index.title")
    render :layout => 'main'
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
