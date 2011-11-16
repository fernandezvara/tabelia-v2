# encoding: UTF-8
class UsersController < ApplicationController
  
  def show
    @user = User.where(:username => params[:username]).first
    
    if @user.nil? == true
      show_404 
    else
      @comment = Comment.new
      @comments = @user.comments_received.order_by(:created_at, :desc).limit(10)
      inspirations = Tagging.of_object_as_where_creator(@user, 'insp', @user)
      @inspirations = Array.new
      inspirations.each do |tag|
        @inspirations << tag.tag.text
      end
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
  end
  
  def index
    #@users = User.order_by(:name, :asc).page(params[:page]).per(30)
    @title = t("users.index.title")
    
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    
    @search = User.search do
      #with(:show_search).greater_than(show_search_level)
      order_by(:name)
      paginate(:per_page => 30, :page => params[:page])
    end
    @users = @search.results
    render :layout => 'main'
  end

  def signup
    @title = t("users.signup.title")
    render :layout => 'first_page'
  end

  def new
    @user = User.new
    @title = t("users.new.title")
    render :layout => 'first_page'
  end

  def new_provider
    @auth = request.env['omniauth.auth']
    remote_user = Authorization.where(:provider => @auth["provider"], :uid => @auth["uid"]).first

    if current_user
      # Si el usuario está validado
      if remote_user.nil? == true
        # añadimos una autorizacion al usuario actual
        @authorization = Authorization.create!(:provider => @auth["provider"], :uid => @auth["uid"], :user => current_user)
        
        # gets the username from twitter and facebook, useful for mentions on twitter and stuff like that
        if @auth['info']['nickname']
          case @auth['provider']
          when 'twitter'
            @authorization.tw_username = @auth['info']['nickname']
          when 'facebook'
            @authorization.fb_username = @auth['info']['nickname']
          end
          @authorization.save if @authorization.changed?
        end
        if @auth['credentials'] and @auth[:provider] == 'facebook'
          @authorization.fb_token = @auth['credentials']['token'] if @auth['credentials']['token']
          @authorization.fb_secret = @auth['credentials']['secret'] if @auth['credentials']['secret']
          @authorization.save if @authorization.changed?
        end
        if @auth['credentials'] and @auth[:provider] == 'twitter'
          @authorization.tw_token = @auth['credentials']['token'] if @auth['credentials']['token']
          @authorization.tw_secret = @auth['credentials']['secret'] if @auth['credentials']['secret']
          @authorization.save if @authorization.changed?
        end 
        flash[:success] = "Servicio añadido a tu cuenta. Ahora puedes iniciar sesión en tabelia con ese usuario"
        redirect_to_or_default(profile_privacy_url)
      else
        if remote_user.user == current_user
          # ya estabas validado.... 
          flash[:error] = "Ya estás validado en tabelia."
          redirect_to_or_default(root_url)
        else
          # debes salir antes de volver a iniciar sesión
          flash[:error] = "El servicio que intentas vincular a tu cuenta pertenece a otro usuario."
          redirect_to_or_default(root_url)
        end
      end
    else
      if remote_user.nil? == true
        @user = User.new
        @user.get_data_from_provider(@auth)
        @user.language = I18n.locale.to_s
        @user.save # :validate => false

        @authorization = Authorization.create!(:provider => @auth["provider"], :uid => @auth["uid"], :user => @user)
        
        # gets the username from twitter and facebook, useful for mentions on twitter and stuff like that
        if @auth['info']['nickname']
          case @auth['provider']
          when 'twitter'
            @authorization.tw_username = @auth['info']['nickname']
          when 'facebook'
            @authorization.fb_username = @auth['info']['nickname']
          end
          @authorization.save if @authorization.changed?
        end
        
        if @auth['credentials'] and @auth[:provider] == 'facebook'
          @authorization.fb_token = @auth['credentials']['token'] if @auth['credentials']['token']
          @authorization.fb_secret = @auth['credentials']['secret'] if @auth['credentials']['secret']
          @authorization.save if @authorization.changed?
        end
        if @auth['credentials'] and @auth[:provider] == 'twitter'
          @authorization.tw_token = @auth['credentials']['token'] if @auth['credentials']['token']
          @authorization.tw_secret = @auth['credentials']['secret'] if @auth['credentials']['secret']
          @authorization.save if @authorization.changed?
        end

        cookies.permanent[:auth_token] = @user.auth_token
        redirect_to(profile_basic_path)
      else
        # validamos usuario
        # gets the username from twitter and facebook, useful for mentions on twitter and stuff like that
        if @auth['info']['nickname']
          case @auth['provider']
          when 'twitter'
            remote_user.tw_username = @auth['info']['nickname']
          when 'facebook'
            remote_user.fb_username = @auth['info']['nickname']
          end
          remote_user.save if remote_user.changed?
        end
        if @auth['credentials'] and @auth[:provider] == 'facebook'
          remote_user.fb_token = @auth['credentials']['token'] if @auth['credentials']['token']
          remote_user.fb_secret = @auth['credentials']['secret'] if @auth['credentials']['secret']
          remote_user.save :validate => false if remote_user.changed?
        end
        if @auth['credentials'] and @auth[:provider] == 'twitter'
          remote_user.tw_token = (@auth['credentials']['token'] rescue nil)
          remote_user.tw_secret = (@auth['credentials']['secret'] rescue nil)
          remote_user.save if remote_user.changed?
        end
        cookies.permanent[:auth_token] = remote_user.user.auth_token
        session[:locale] = remote_user.user.language
        notice = "Logged in!"
        redirect_to_or_default(root_url, :notice => notice)
      end
    end
  end

  def failure
    @auth = request.env['omniauth.auth']
    render :layout => 'first_page'
  end

  def username_exists
    # TODO: Implement it!
    # devuelve si el nombre de usuario ya existe.
    @response = User.username_exists?(params[:username])
    respond_to do |format|
      format.json { @response.to_json }
    end
  end

  def edit
    # TODO: clean this
    @user = current_user
    @title = t("users.edit.title")
    render :layout => 'main'
  end

  def update
    # TODO: clean this
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to :root
    else
      render :action => :edit, :layout => 'main'
    end
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
