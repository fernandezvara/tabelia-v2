class ShopController < ApplicationController
  def popular_photos
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    if params[:subject] == '_'
      subject = nil
    else
      subject = params[:subject]
    end
    if params[:tecnique] == '_'
      tecnique = nil
    else
      tecnique = params[:tecnique]
    end
    @search = Sunspot.search(Art) do
      with(:photo, true)
      with(:show_search).greater_than(show_search_level)
      with(:subject_slug, params[:subject]) if subject
      with(:tecnique_slug, params[:tecnique]) if tecnique
      order_by(:popularity, :desc)
      paginate(:per_page => 16, :page => params[:page])
    end
    @arts = @search.results
    @title = t('arts.photos_by_popularity')
    respond_to do |format|
      format.html { render :layout => 'shop' }
      format.js
    end
  end
  
  def popular_paintings
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    if params[:category] == '_'
      category = nil
    else
      category = params[:category]
    end
    if params[:idiom] == '_'
      idiom = nil
    else
      idiom = params[:idiom]
    end
    @search = Sunspot.search(Art) do
      with(:photo, false)
      with(:show_search).greater_than(show_search_level)
      with(:category_slug, category) if category
      with(:genre_slug, idiom) if idiom
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
      order_by(:popularity, :desc)
      paginate(:per_page => 16, :page => params[:page])
    end
    @arts = @search.results
    puts "arts.count = #{@arts.count}"
    @title = t('arts.paintings_by_populatity')
    respond_to do |format|
      format.html { render :layout => 'shop' }
      format.js
    end
  end

  def photos
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    if params[:subject] == '_'
      subject = nil
    else
      subject = params[:subject]
    end
    if params[:tecnique] == '_'
      tecnique = nil
    else
      tecnique = params[:tecnique]
    end
    @search = Sunspot.search(Art) do
      with(:photo, true)
      with(:show_search).greater_than(show_search_level)
      with(:subject_slug, params[:subject]) if subject
      with(:tecnique_slug, params[:tecnique]) if tecnique
      order_by(:name, :asc)
      paginate(:per_page => 16, :page => params[:page])
    end
    @arts = @search.results
    @title = t('arts.photos_title')
    respond_to do |format|
      format.html { render :layout => 'shop' }
      format.js
    end
  end

  def paintings
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    if params[:category] == '_'
      category = nil
    else
      category = params[:category]
    end
    if params[:idiom] == '_'
      idiom = nil
    else
      idiom = params[:idiom]
    end
    @search = Sunspot.search(Art) do
      with(:photo, false)
      with(:show_search).greater_than(show_search_level)
      with(:category_slug, category) if category
      with(:genre_slug, idiom) if idiom
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
      paginate(:per_page => 16, :page => params[:page])
    end
    @arts = @search.results
    puts "arts.count = #{@arts.count}"
    @title = t('arts.paintings_title')
    respond_to do |format|
      format.html { render :layout => 'shop' }
      format.js
    end
  end

end
