class ProfileController < ApplicationController
  def basic
    @user = current_user
    if params[:user]
      if @user.update_attributes(params[:user])
        if @user.email_changed?
          # debe crear la tarea de envio de nueva confirmacion
        end
        flash.now[:success] = 'Cambios guardados correctamente'
      else
        flash.now[:error] = 'Hay errores en el formulario'
      end
    end
    @title = t("profile.edit.title")
    respond_to do |format|
      format.html {render :layout => 'main'}
      format.js
    end
  end

  def about
    @user = current_user
    if params[:user]
      if @user.update_attributes(params[:user])
        flash.now[:success] = 'Cambios guardados correctamente'
      else
        flash.now[:error] = 'Por favor, corrige los errores'
      end
    end
    @title = t("profile.edit.title")
    inspirations = Tagging.of_object_as_where_creator(@user, 'insp', current_user)
    tags = Array.new
    inspirations.each do |tag|
      tags << tag.tag.text
    end
    @inspirations = tags.join(',')
    
    respond_to do |format|
      format.html {render :layout => 'main'}
      format.js
    end
  end

  def avatar
    @user = current_user
    if params[:user]
      if @user.update_attributes(params[:user])
        flash.now[:success] = 'Cambios guardados correctamente'
      else
        flash.now[:error] = 'Hay errores en el formulario'
      end
    end
    @title = t("profile.edit.title")
    respond_to do |format|
      format.html {render :layout => 'main'}
      format.js
    end
  end

  def privacy
  end

  def services
  end

  def basic_update
  end

  def about_update
  end

  def avatar_update
  end

  def privacy_update
  end

  def services_update
  end

end
