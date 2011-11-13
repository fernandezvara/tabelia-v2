class LocaleController < ApplicationController

  def set
    if params[:language]
      locale = params[:language]
      if I18n.available_locales.include?(locale.to_sym)
        I18n.locale = locale.to_sym
        session[:locale] = locale
        flash[:notice] = "#{locale} - Translation changed"
        if current_user
          current_user.locale = locale
          current_user.save
        end
      else
        flash[:notice] = "#{params[:locale]} - Translation not available"
        logger.error flash.now[:notice]
      end
    end
    redirect_to_or_default()
  end

  def change
    @languages = LANGUAGES
  end

end
