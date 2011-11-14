class LocaleController < ApplicationController

  def set
    if params[:language]
      locale = params[:language]
      if I18n.available_locales.include?(params[:language].to_sym)
        I18n.locale = params[:language].to_sym
        session[:locale] = params[:language]
        if current_user
          u = current_user
          u.language = params[:language].to_s
          if u.save!
            puts "+++++++ cambiado OK"
            puts "current_user = #{u.language}"
          else
            puts "------- cambiado ERROR"
          end
        end
      else
        logger.error "No se ha podido cambiar el idioma: #{params[:language]}"
      end
    end
    redirect_to_or_default()
  end

  def change
    @languages = LANGUAGES
  end

end
