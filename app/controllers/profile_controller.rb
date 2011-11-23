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
    @privacy = current_user.privacy
    if params[:privacy]
      if @privacy.update_attributes(params[:privacy])
        current_user.save
        # update arts, applies new privacy settings
        arts = current_user.arts.all
        arts.each do |art|
          art.save
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

  def services
    @current_user = current_user
    @title = t("profile.edit.title")
    respond_to do |format|
      format.html {render :layout => 'main'}
      format.js
    end
  end

end
