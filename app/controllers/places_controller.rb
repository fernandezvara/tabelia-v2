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
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def create
    if current_user
      @place = Place.new(params[:place])  
      if @place.save
        redirect_to place_path(:id => @place.slug)
      else
        flash.now[:error] = t('places.error_in_form')
        respond_to do |format|
          format.html { render :action => 'new', :layout => 'main2' }
        end
      end
    else
      redirect_to :not_found
    end
  end

  def edit
    @place = Place.where(:slug => params[:id]).first
    if current_user and @place.nil? == false and @place.user_id == current_user.id
      @title = t('places.edit_place')
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
    
  end

  def update
    puts 'paso por update'
    @place = Place.where(:slug => params[:id]).first
    if current_user and @place.nil? == false and @place.user == current_user 
      if @place.update_attributes(params[:place])
        flash[:success] = t('places.success_edit')
        redirect_to place_path(:id => @place.slug)
      else
        flash.now[:error] = t('places.error_in_form')
        respond_to do |format|
          format.html { render :action => 'new', :layout => 'main' }
        end
      end
    else
      redirect_to :not_found
    end
  end

  def show
    @place = Place.where(:slug => params[:id]).first
    if @place.nil? == false
      @agenda = Event.where(:place_id => @place.id, :finish.gte => Time.now.utc.beginning_of_day).order_by(:start, :asc)
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def my
  end

  def search
    @search = Sunspot.search(Place) do 
      #keywords params[:input], :fields => :name
      fulltext(params[:input])
      paginate(:per_page => params[:limit], :page => 1)
    end
    
    results_array = Array.new
    @search.results.each do |r|
      newitem = Hash.new
      newitem['id'] = r.id.to_s
      newitem['value'] = r.name
      newitem['info'] = [r.city, r.country.name].join(', ')
      results_array.push(newitem)
    end
    
    results_hash = Hash.new
    results_hash['results'] = results_array
    
    respond_to do |format|
      format.json { render json: results_hash }
    end
  end

end
