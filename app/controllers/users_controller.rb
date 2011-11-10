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
    render :layout => 'main'
  end

  def new
    @user = User.new
    @title = t("users.new.title")
    render :layout => 'main'
  end

  def new_provider
    @user = User.new
    # @user.first_name = auth........ Debemos rellenar los datos
    # Hay que cambiar los usuarios, deben tener un first_name y last_name y un self.name que los concatene, permitirá organizar
    # por nombre, apellidos, etc, habrá que cambiar también las reglas de sunspot
    # además debe asignar un user-name que no exista ya
    @title = t("users.new.title")
    render :layout => 'main'
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
