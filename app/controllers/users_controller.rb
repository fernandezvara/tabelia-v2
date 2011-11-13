class UsersController < ApplicationController
  
  def show
    @user = User.where(:username => params[:username]).first
    
    if @user.nil? == true
      show_404 
    else
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
  end
  
  def index
    @users = User.order_by(:name, :asc).page(params[:page]).per(30)
    @title = t("users.index.title")
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
    # @user.first_name = auth........ Debemos rellenar los datos
    # Hay que cambiar los usuarios, deben tener un first_name y last_name y un self.name que los concatene, permitirá organizar
    # por nombre, apellidos, etc, habrá que cambiar también las reglas de sunspot
    # además debe asignar un user-name que no exista ya
    
    
    @auth = request.env['omniauth.auth']
    remote_user = Authorization.where(:provider => @auth["provider"], :uid => @auth["uid"]).first

    if remote_user.nil? == true
      # no existe el usuario...
      
      puts ' ---- AUTH ---- ' 
      puts @auth.inspect.to_yaml
      
      @user = User.new
      @user.get_data_from_provider(@auth)
      puts '**** USER.INSPECT ****'
      puts @user.inspect
      @user.save!
      @authorization = Authorization.create!(:provider => @auth["provider"], :uid => @auth["uid"], :user => @user)
      
      cookies.permanent[:auth_token] = @user.auth_token
      
      @title = t("users.new.title")
      render :layout => 'first_page'
    else
      cookies.permanent[:auth_token] = remote_user.user.auth_token
      notice = "Logged in!"
      redirect_to_or_default(root_url, :notice => notice)
    end

  end

  def failure
    @auth = request.env['omniauth.auth']
    render :layout => 'first_page'
  end

  def create
    # deberá crear el usuario, además debe crear la tarea Resque para que envíe el correo de confirmación.
    # se llamará a este create usando data-remote, de forma que si hay un error de validación debe reescribir el formulario,
    # que estará englobado en <div id="new_user_form"> ... </div>
  end

  def username_exists
    # devuelve si el nombre de usuario ya existe.
    @response = User.username_exists?(params[:username])
    respond_to do |format|
      format.json { @response.to_json }
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = t("users.new.title")
    render :layout => 'main'
    
  end


  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to :root
    else
      render :action => 'edit', :layout => 'main'
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
