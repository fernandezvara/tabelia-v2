class ColorController < ApplicationController
  def index
    if params[:color]
      @color = params[:color]
      relations = Color.near_colors(params[:color], 8)
      @arts = Array.new
      relations.each do |rel|
        @arts << rel.art if @arts.include?(rel.art) == false
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
