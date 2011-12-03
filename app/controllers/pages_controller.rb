class PagesController < ApplicationController
  def index
    if current_user
      @cache = "front-page-logged-#{rand(10)}"
      @cache_photos = "front-page-logged-photos-#{rand(10)}"
      if fragment_exist?(@cache) == false
        @search = Art.search do
           with(:show_search).greater_than(1)
           with(:photo, false)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
      end
      if fragment_exist?(@cache_photos) == false
        @search_photos = Art.search do
           with(:show_search).greater_than(1)
           with(:photo, true)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
      end
      respond_to do |format|
        format.html { render :layout => 'splash' }
      end
    else
      @cache = "front-non-logged-#{rand(10)}"
      @cache_photos = "front-non-logged-photos-#{rand(10)}"
      if fragment_exist?(@cache) == false
        @search = Art.search do
           with(:show_search).greater_than(2)
           with(:photo, false)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
      end
      if fragment_exist?(@cache_photos) == false
        @search_photos = Art.search do
           with(:show_search).greater_than(1)
           with(:photo, true)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
      end
      
      respond_to do |format|
        format.html { render  'notloggedin', :layout => 'first_page' }
      end
    end
  end

  def help
    @title = t('common.how_tabelia_works')
    respond_to do |format|
      format.html do
        render :layout => 'full_page'
      end
    end
  end

  def big_art
    @title = t('common.big_art')
    respond_to do |format|
      format.html do
        render :layout => 'full_page'
      end
    end
  end

  def notloggedin
  end

  def not_found
    respond_to do |format|
      format.html do
        render :layout => 'main', :status => 404
      end
    end
  end

  def terms
    respond_to do |format|
      format.html do
        render :layout => 'main'
      end
    end
  end
  
  def jobs
    respond_to do |format|
      format.html do
        render :layout => 'main'
      end
    end
  end

  def confirmation
    respond_to do |format|
      format.html do 
        render :layout => 'application'
      end
    end
  end
end
