class ColorController < ApplicationController
  def index
    if params[:color]
      @color = params[:color]
      relations = Color.near_colors(params[:color], 8)
      @arts = Array.new
      case params[:view]
      when "1"
        show = 1
      when '0'
        show = 0
      else
        show = 2
      end
      relations.each do |rel|
        if show == 0
          if @arts.include?(rel.art) == false and rel.art.photo == false and rel.art.accepted == true
            @arts << rel.art
          end
        end
        if show == 1
          if @arts.include?(rel.art) == false and rel.art.photo == true and rel.art.accepted == true
            @arts << rel.art
          end
        end
        if show == 2
          @arts << rel.art if @arts.include?(rel.art) == false and rel.art.accepted == true
        end
      end
    else
      @color = 'ffffff'
      @arts = []
    end
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

end
