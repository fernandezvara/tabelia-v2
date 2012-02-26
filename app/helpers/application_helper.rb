# encoding: UTF-8
module ApplicationHelper
  def title
    if @title.nil?
      'tabelia'
    else
      'tabelia' + " · " + @title
    end
  end
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, time.to_s, options.merge(:datetime => time.getutc.iso8601)) if time
  end
  
  def timeagoright(time, options = {})
    options[:class] ||= "timeagoright"
    content_tag(:time, time.to_s, options.merge(:datetime => time.getutc.iso8601)) if time
  end
  
  def flag(country)
    image_tag("//assets.tabelia.com/assets/countries/#{country.code}.png".downcase, :alt => country.name)
  end
  
  def fotolia_category_name(id)
    #Existe en el helper y en el controller!!!!! Es necesario cambiar los dos!!!!!
    case I18n.locale.to_s
    when 'en'
      case id.to_i
      when 1000000
        return 'Landscapes'
      when 2000000
        return 'Architecture'
      when 3000000
        return 'People'
      when 4000000
        return 'Animals and Plants'
      when 5000000
        return 'Objects'
      when 6000000
        return 'Transportation'
      when 7000000
        return 'Food and Drink'
      when 8000000
        return 'Sports and Leisure'
      when 9000000
        return 'Backgrounds and Textures'
      when 10000000
        return 'Abstract'
      when 99000000
        return 'Others'
      end
    when 'es'
      case id.to_i
      when 1000000
        return 'Paisaje'
      when 2000000
        return 'Arquitectura'
      when 3000000
        return 'Personas'
      when 4000000
        return 'Animales y Plantas'
      when 5000000
        return 'Objetos'
      when 6000000
        return 'Transporte'
      when 7000000
        return 'Gastronomía'
      when 8000000
        return 'Deporte y Tiempo Libre'
      when 9000000
        return 'Fondo y Textura'
      when 10000000
        return 'Abstracto'
      when 99000000
        return 'Otros'
      end
    end
  end
  
end