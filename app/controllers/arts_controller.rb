# encoding: UTF-8
class ArtsController < ApplicationController
  
  force_ssl :only => [ :index, :new, :create, :edit, :update ]
  
  def show
    @art = Art.where(:slug => params[:slug], :photo => false).first

    if @art.nil? == true
      show_404 
    else
      @cart = current_cart

      if params[:item_id]
        @item = Item.find(params[:item_id])
      else
        @item = Item.new
      end
      
      puts @art.inspect 
      
      if @art.aod == true
        @min_height = @art.aod_min_height
        @min_width = @art.aod_min_width
      else
        @min_height = @art.min_height
        @min_width = @art.min_width
      end
      
      @max_height = @art.max_height
      @max_width = @art.max_width
      @correction = @art.dimension_correction
      
      puts @min_height
      puts @min_width
      if @item.new?
        case params[:material]
        when 'canvas'
          @tabelia_price = @art.get_price(@min_height, @min_width, 3, 0).to_f
          @material = 3
        when 'photographic'
          @tabelia_price = @art.get_price(@min_height, @min_width, 2, 0).to_f
          @material = 2
        when 'watercolor'
          @tabelia_price = @art.get_price(@min_height, @min_width, 4, 0).to_f
          @material = 4
        when 'aluminium'
          @tabelia_price = @art.get_price_fixed(5, 's', 0).to_f
          @material = 5
        else
          @tabelia_price = @art.get_price(@min_height, @min_width, 3, 0).to_f
          @material = 3
        end
      else
        if @item.frame == true
          framed = 1
        else
          framed = 0
        end
        case params[:material]
        when 'canvas'
          @tabelia_price = @art.get_price(@item.height, @item.width, 3, framed).to_f
          @material = 3
        when 'photographic'
          @tabelia_price = @art.get_price(@item.height, @item.width, 2, 0).to_f
          @material = 2
        when 'watercolor'
          @tabelia_price = @art.get_price(@item.height, @item.width, 4, 0).to_f
          @material = 4
        when 'aluminium'
          @tabelia_price = @art.get_price_fixed(5, @item.size, framed).to_f
          @material = 5
        else
          @tabelia_price = @art.get_price(@item.height, @item.width, 3, framed).to_f
          @material = 3
        end
      end
      
      if @item.new?
        @art_price = @art.quote(@min_height, @min_width, @art.aod, @material, 's')
      else
        @art_price = @art.quote(@item.height, @item.width, @art.aod, @item.media_id, 's')
      end
      
      @total = @art_price + @tabelia_price
      
      # verify if art has been published
      if @art.accepted == true and @art.status == true
        if request.env['HTTP_REFERER'].nil? == true
          referrer = "-"
        else
          referrer = request.env['HTTP_REFERER']
        end
        if current_user
          if @art.user != current_user
            Resque.enqueue(VisitNew, referrer, @art.class.to_s, @art.id.to_s, session[:session_id], current_user.id.to_s)
          end
        else
          Resque.enqueue(VisitNew, referrer, @art.class.to_s, @art.id.to_s, session[:session_id], "")
        end
        arttags = Tagging.of_object_as_where_creator(@art, 'arttag', @art.user)
        @tags = Array.new
        arttags.each do |tag|
          @tags << tag.tag.text
        end
        similar_arts = ArtSimilar.where(:art_id => @art.id.to_s, :photo => @art.photo).limit(8)
        @similar_art = Array.new
        similar_arts.each do |similar|
          temp_art = Art.find(similar.similar_id)
          if temp_art.photo == false
            begin
            @similar_art << Art.find(similar.similar_id)
            rescue
            end
          end
        end
        @art_colors = ColorRelation.colors_of(@art)
        @title = @art.name
        render :layout => 'product'
      else
        # if the art has not been published by the artist or is not accepted, we only show the art to the artist
        if @art.user == current_user
          arttags = Tagging.of_object_as_where_creator(@art, 'arttag', @art.user)
          @tags = Array.new
          arttags.each do |tag|
            @tags << tag.tag.text
          end
          similar_arts = ArtSimilar.where(:art_id => @art.id.to_s, :photo => @art.photo).limit(4)
          @similar_art = Array.new
          similar_arts.each do |similar|
            temp_art = Art.find(similar.similar_id)
            if temp_art.photo == false
              begin
              @similar_art << Art.find(similar.similar_id)
              rescue
              end
            end
          end
          @art_colors = ColorRelation.colors_of(@art)
          @title = t("users.index.title")
          render :layout => 'product'
        else
          # art not belongs to the user
          show_404
        end
      end
    end
  end

  def user_art_show
    @user = User.where(:username => params[:username]).first
    if @user.nil? == true
      show_404
    else   
      @arts = @user.arts.where(:photo => false, :accepted => true, :status => true).page(params[:page]).per(30)
      @title = t("users.index.title")
      respond_to do |format|
        format.html { render :layout => 'main' }
        format.js
      end
    end
  end

  def index
    if current_user
      @arts = current_user.arts.where(:photo => false).page(params[:page]).per(30)
      @title = t("arts.index.title")
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def new
    @art = Art.new
    @title = t("arts.new.title")
    @tags = ""
    respond_to do |format|
      format.html { render :layout => 'main2' }
    end
  end

  def create
    @art = Art.new
    @art.photo = false 
    @art.name =               params[:art][:name]
    @art.description =        params[:art][:description]
    @art.price =              params[:art][:price]
    @art.price_a4 =           params[:art][:price_a4]
    @art.price_a3 =           params[:art][:price_a3]
    @art.price_artistic =     params[:art][:price_artistic]
    @art.price_wallcovering = params[:art][:price_wallcovering]
    @art.category_id =        params[:art][:category_id]
    @art.status =             params[:art][:status]
    @art.tags =               params[:art][:tags]
    @art.user =               current_user
    @art.genre_id =           params[:art][:genre_id]
    @art.m_oil =              params[:art][:m_oil]
    @art.m_watercolor =       params[:art][:m_watercolor]
    @art.m_hot_wax =          params[:art][:m_hot_wax]
    @art.m_pastel =           params[:art][:m_pastel]
    @art.m_gouache =          params[:art][:m_gouache]
    @art.m_tempera =          params[:art][:m_tempera]
    @art.m_ink =              params[:art][:m_ink]
    @art.m_graphite =         params[:art][:m_graphite]
    @art.m_charcoal =         params[:art][:m_charcoal]
    @art.m_sepia =            params[:art][:m_sepia]
    @art.m_sanguine =         params[:art][:m_sanguine]
    @art.m_crayon =           params[:art][:m_crayon]
    @art.m_acrylic =          params[:art][:m_acrylic]
    @art.m_aerography =       params[:art][:m_aerography]
    @art.m_marker_pen =       params[:art][:m_marker_pen]
    @art.m_colored_pencil =   params[:art][:m_colored_pencil]
    @art.m_digital =          params[:art][:m_digital]
    @art.m_mixed =            params[:art][:m_mixed]
    if params[:art][:original].nil? == false
      # only trigger the resque queue if new image
      @art.original = params[:art][:original]
      @art.accepted = false
      image_changed = true
    else
      image_changed = false
    end
    if @art.save == true
      if image_changed == true
        # avoid original = nil!
        Resque.enqueue(ColorsFromImage, @art.id.to_s)
      end
      Resque.enqueue(AdminNotification, current_user.id.to_s, @art.id.to_s)
      Resque.enqueue(FindSimilarArt, @art.id.to_s)
      flash[:success] = "#{@art.name} added correctly."
      redirect_to arts_path
    else
      flash[:error] = t('common.please_fix_errors_on_form')
      render 'new', :layout => 'main2'
    end
  end

  def edit
    @art = Art.where(:slug => params[:slug]).first
    @title = t("arts.edit.title", :art_name => @art.name)
    arttags = Tagging.of_object_as_where_creator(@art, 'arttag', current_user)
    tags = Array.new
    arttags.each do |tag|
      tags << tag.tag.text
    end
    @tags = tags.join(',')
    respond_to do |format|
      format.html { render :layout => 'main2' }
    end
  end

  def update
    @art = Art.where(:slug => params[:art][:slug]).first
    @art.photo = false 
    @art.name =             params[:art][:name]
    @art.description =      params[:art][:description]
    @art.price =            params[:art][:price]
    @art.price_a4 =           params[:art][:price_a4]
    @art.price_a3 =           params[:art][:price_a3]
    @art.price_artistic =     params[:art][:price_artistic]
    @art.price_wallcovering = params[:art][:price_wallcovering]
    @art.category_id =      params[:art][:category_id]
    @art.genre_id =         params[:art][:genre_id]
    @art.status =           params[:art][:status]
    @art.tags =             params[:art][:tags]
    @art.m_oil =            params[:art][:m_oil]
    @art.m_watercolor =     params[:art][:m_watercolor]
    @art.m_hot_wax =        params[:art][:m_hot_wax]
    @art.m_pastel =         params[:art][:m_pastel]
    @art.m_gouache =        params[:art][:m_gouache]
    @art.m_tempera =        params[:art][:m_tempera]
    @art.m_ink =            params[:art][:m_ink]
    @art.m_graphite =       params[:art][:m_graphite]
    @art.m_charcoal =       params[:art][:m_charcoal]
    @art.m_sepia =          params[:art][:m_sepia]
    @art.m_sanguine =       params[:art][:m_sanguine]
    @art.m_crayon =         params[:art][:m_crayon]
    @art.m_acrylic =        params[:art][:m_acrylic]
    @art.m_aerography =     params[:art][:m_aerography]
    @art.m_marker_pen =     params[:art][:m_marker_pen]
    @art.m_colored_pencil = params[:art][:m_colored_pencil]
    @art.m_digital =        params[:art][:m_digital]
    @art.m_mixed =          params[:art][:m_mixed]
    
    if params[:art][:original].nil? == false
      # only trigger the resque queue if new image
      @art.original = params[:art][:original]
      @art.accepted = false
      image_changed = true
    else
      image_changed = false
    end
    if @art.save!
      if image_changed == true
        # avoid original = nil!
        Resque.enqueue(ColorsFromImage, @art.id.to_s)
      end
      Resque.enqueue(FindSimilarArt, @art.id.to_s)
      flash[:success] = "#{@art.name} edited correctly."
      redirect_to arts_path
    end
  end
  
  def likes
    @art = Art.where(:slug => params[:slug]).first
    @likes = GraphClient.get_criteria("Backward", "Like", @art)
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end
  
  def add_to_cart
    @art = Art.where(:slug => params[:slug]).first
    @cart = current_cart
    @item = Item.new
    @min_width = @art.min_width
    @min_height = @art.min_height
    @correction = @art.dimension_correction
    @artist_price = (@art.price).to_f.round(2)
    @tabelia_price = @art.get_price(@min_height, @min_width, 1, 0).to_f
    @total = @artist_price + @tabelia_price
  end
end