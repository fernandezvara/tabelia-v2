class UsersController < ApplicationController
  
  def show
    @user = User.where(:username => params[:username]).first
    @comment = Comment.new
    @comments = @user.comments_received.order_by(:created_at, :desc).limit(10)
    @title = @user.name.to_s
    if request.env['HTTP_REFERER'].nil? == true
      referrer = "-"
    else
      referrer = request.env['HTTP_REFERER']
    end
    if current_user
      if @user != current_user
        Resque.enqueue(VisitNew, referrer, @user.class.to_s, @user.id.to_s, session[:session_id], current_user.id.to_s)
      end
    else
      Resque.enqueue(VisitNew, referrer, @user.class.to_s, @user.id.to_s, session[:session_id], "")
    end
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end
  
  def index
    @users = User.order_by(:name, :asc).page(params[:page]).per(30)
    @title = t("users.index.title")
    render :layout => 'main'
  end

  def new
  end

  def create
  end



  def update
  end

  def followers
    @user = User.where(:username => params[:username]).first
    @followers = GraphClient.get("Backward", "Follow", @user)
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end
  
  def following
    @user = User.where(:username => params[:username]).first
    @following = GraphClient.get("Forward", "Follow", @user)
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

end
