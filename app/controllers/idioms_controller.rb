class IdiomsController < ApplicationController
  def show
    @idiom = Genre.where(:slug => params[:slug]).first
    if @idiom.nil? == true
      show_404
    else
      if current_user
        show_search_level = 1
      else
        show_search_level = 2
      end
      if params[:style].nil? == false and params[:style] != ''
        style = params[:style]
      else
        style = nil
      end
      @search = Art.search do
        with(:photo, false)
        with(:show_search).greater_than(show_search_level)
        with(:genre_slug, params[:slug])
        with(:category_slug, style) if style.nil? == false
        with(:m_oil, true) if params[:tecnique] == 'oil'
        with(:m_watercolor, true) if params[:tecnique] == 'watercolor'
        with(:m_hot_wax, true) if params[:tecnique] == 'hot_wax'
        with(:m_pastel, true) if params[:tecnique] == 'pastel'
        with(:m_gouache, true) if params[:tecnique] == 'gouache'
        with(:m_tempera, true) if params[:tecnique] == 'tempera'
        with(:m_ink, true) if params[:tecnique] == 'ink'
        with(:m_graphite, true) if params[:tecnique] == 'graphite'
        with(:m_charcoal, true) if params[:tecnique] == 'charcoal'
        with(:m_sepia, true) if params[:tecnique] == 'sepia'
        with(:m_sanguine, true) if params[:tecnique] == 'sanguine'
        with(:m_crayon, true) if params[:tecnique] == 'crayon'
        with(:m_acrylic, true) if params[:tecnique] == 'acrylic'
        with(:m_aerography, true) if params[:tecnique] == 'aerography'
        with(:m_marker_pen, true) if params[:tecnique] == 'marker_pen'
        with(:m_colored_pencil, true) if params[:tecnique] == 'colored_pencil'
        with(:m_digital, true) if params[:tecnique] == 'digital'
        with(:m_mixed, true) if params[:tecnique] == 'mixed'
        order_by(:name, :asc)
        paginate(:per_page => 30, :page => params[:page])
      end
      @arts = @search.results
      @title = @idiom.name
      respond_to do |format|
        format.html { render :layout => 'main' }
        format.js
      end
    end
  end
end
