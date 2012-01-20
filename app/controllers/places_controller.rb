class PlacesController < ApplicationController
  def welcome
  end

  def index
  end

  def new
    if current_user
      @place = Place.new
      @title = t('places.new_place')
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def create
    if current_user
      @place = Place.new(params[:place])  
      if @place.save
        redirect_to place_profile_path(:slug => @place.slug)
      else
        flash.now[:error] = t('place.error_in_form')
        respond_to do |format|
          format.html { render :action => 'new', :layout => 'main' }
        end
      end
    else
      redirect_to :not_found
    end
  end

  def edit
    @place = Place.where(:slug => params[:slug]).first
    if current_user and @place.nil? == false and @place.user_id == current_user.id
      @title = t('places.edit_place')
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
    
  end

  def update
  end

  def show
    @place = Place.where(:slug => params[:slug]).first
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end

  def my
  end

end
