# encoding: UTF-8
class StockController < ApplicationController
  def index
  end

  def gallery
    f = fotolia_client
    
    if params[:page].nil? == false
      @page = params[:page].to_i
      offset = (@page - 1) * 48
    else
      @page = 1
      offset = 0
    end
    
    # f.execute('search', 'getSearchResults', { :language_id => 5, :search_parameters => { :offset => offset, :filters => { :content_type => 'photo', :"license_XL:on" => 1 }, :cat1_id => params[:cat1_id] } })
    
    search_response = f.execute('search', 'getSearchResults', { :language_id => 5, :search_parameters => { :cat1_id => params[:id], :offset => offset, :limit => 48, :filters => { :content_type => 'photo', :"license_XL:on" => 1 } } })
    @search = search_response.response
    
    @items = @search['nb_results']
    @title = fotolia_category_name(params[:id].to_i)
    
    respond_to do |format|
      format.html { render :layout => 'main2' }
    end
    
  end

  def search
    f = fotolia_client
    
    if params[:page].nil? == false
      @page = params[:page].to_i
      offset = (@page - 1) * 48
    else
      @page = 1
      offset = 0
    end
    
    if params[:q]
      search_response = f.execute('search', 'getSearchResults', { :language_id => 5, :search_parameters => { :words => params[:q], :offset => offset, :limit => 48, :filters => { :content_type => 'photo', :"license_XL:on" => 1 } } })
      @search = search_response.response
      @title = params[:q]      
    else
      @search = nil
      @title = 'Búsqueda de fotografías'
    end
    

    
    respond_to do |format|
      format.html { render :layout => 'main2' }
    end
  end

  def show
    f = fotolia_client
    
    image_response = f.execute('media', 'getMediaData', { :language_id => fotolia_language_id, :thumbnail_size => 400, :id => params[:id] } )
    @image = image_response.response
    
    similar_response = f.execute('search', 'getSearchResults', { :language_id => fotolia_language_id, :search_parameters => { :similia_id => params[:id], :limit => 8, :filters => { :content_type => 'photo', :"license_XL:on" => 1 } } })
    @similar = similar_response.response
    
    @title = @image['title']
    
    @cart = current_cart
    
    if params[:item_id]
      @item = Item.find(params[:item_id])
    else
      @item = Item.new
    end

    # Getting the width and height from the image
    if @image['licenses_details']['L']
      @width = @image['licenses_details']['L']['width'].to_f
      @height = @image['licenses_details']['L']['height'].to_f
      @correction = @width / @height
      @license = 'L'
    end
    puts "#{@width} x #{@height} -> #{@correction} -> #{@license}"
    
    if @image['licenses_details']['XL']
      @width = @image['licenses_details']['XL']['width'].to_f
      @height = @image['licenses_details']['XL']['height'].to_f
      @correction = @width / @height
      @license = 'XL'
    end
    puts "#{@width} x #{@height} -> #{@correction} -> #{@license}"
    if @image['licenses_details']['XXL']
      @width = @image['licenses_details']['XXL']['width'].to_f
      @height = @image['licenses_details']['XXL']['height'].to_f
      @correction = @width / @height
      @license = 'XXL'
    end
    puts "#{@width} x #{@height} -> #{@correction} -> #{@license}"
    
    # Calculate license cost
    @image['licenses'].each do |k|
      puts "#{k['name']} -> #{k['price']}"
      if k['name'] == @license
        @credits = k['price'].to_i
        @license_cost = @credits * 1.3
      end
    end
    
    puts "#{@credits} -> #{@license_cost}"
    
    if @width > @height
      @max_height = 100
      @min_height = 20
      @max_width = (100 * @correction).round(2)
      @min_width = (20 * @correction).round(2)
    else
      @max_width = 100
      @min_width = 20
      @max_height = (100 * @correction).round(2)
      @min_height = (20 * @correction).round(2)
    end
    
    if @width == @height
      @max_width = 100
      @min_width = 20
      @max_height = 100
      @min_height = 20
    end
    
    puts @max_width
    puts @min_width
    puts @max_height
    puts @min_height
    puts @correction
    
    # Calling to an Art class to get the prices
    @art = Art.where(:slug => 'fotolia').first
    if @item.new?
      @item.warp = 0
      @item.frame = 0
      case params[:material]
      when 'canvas'
        @tabelia_price = @art.get_price(@min_height, @min_width, 3, 0, 0).to_f
      when 'photographic'
        @tabelia_price = @art.get_price(@min_height, @min_width, 2, 0, 0).to_f
      when 'watercolor'
        @tabelia_price = @art.get_price(@min_height, @min_width, 4, 0, 0).to_f
      when 'aluminium'
        @tabelia_price = @art.get_price_fixed(5, 's', 0).to_f
      else
        @tabelia_price = @art.get_price(@min_height, @min_width, 3, 0, 0).to_f
      end
    else
      case params[:material]
      when 'canvas'
        @tabelia_price = @art.get_price(@item.height, @item.width, 3, @item.warp, @item.frame).to_f
      when 'photographic'
        @tabelia_price = @art.get_price(@item.height, @item.width, 2, @item.warp, @item.frame).to_f
      when 'watercolor'
        @tabelia_price = @art.get_price(@item.height, @item.width, 4, @item.warp, @item.frame).to_f
      when 'aluminium'
        @tabelia_price = @art.get_price_fixed(5, @item.size, @item.frame).to_f
      else
        @tabelia_price = @art.get_price(@item.height, @item.width, 3, @item.warp, @item.frame).to_f
      end
    end
  
    @art_price = @license_cost
    @total = @license_cost + @tabelia_price
    
    respond_to do |format|
      format.html { render :layout => 'product' }
    end
    
  end

  def creator
    f = fotolia_client
    
    if params[:page].nil? == false
      @page = params[:page].to_i
      offset = (@page - 1) * 48
    else
      @page = 1
      offset = 0
    end
    
    # f.execute('search', 'getSearchResults', { :language_id => 5, :search_parameters => { :offset => offset, :filters => { :content_type => 'photo', :"license_XL:on" => 1 }, :cat1_id => params[:cat1_id] } })
    
    search_response = f.execute('search', 'getSearchResults', { :language_id => 5, :search_parameters => { :creator_id => params[:id], :offset => offset, :limit => 48, :filters => { :content_type => 'photo', :"license_XL:on" => 1 } } })
    @search = search_response.response
    
    @items = @search['nb_results']
    begin
      @title = @search['0']['creator_name']
    rescue
      @title = ''
    end
    
    respond_to do |format|
      format.html { render :layout => 'main2' }
    end
  end


  def fotolia_client
    FotoliaRest::Client.new('WSfE8EmGSKWUrGpDVRS30n6M1ZOmsLnF', 'retocontinuo', 'Enertia22')
  end
  
  def fotolia_language_id
    case I18n.locale.to_s
    when 'en'
      return 2
    when 'es'
      return 5
    end
  end


end
