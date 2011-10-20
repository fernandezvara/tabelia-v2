class ColorController < ApplicationController
  def index
    relations = Color.near_colors(params[:color], 8)
    @arts = Array.new
    relations.each do |rel|
      @arts << rel.art if @arts.include?(rel.art) == false
    end
    puts @arts.inspect
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

end
