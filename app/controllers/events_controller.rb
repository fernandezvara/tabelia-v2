# encoding: utf-8
class EventsController < ApplicationController
  def index
    if current_user
      @events = current_user.events.order_by(:start, :asc).page(params[:page]).per(30)
      @title = t("events.index.title")
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def show
    @event = Event.where(:slug => params[:id]).first
    if @event
      @place = Place.find(@event.place_id)
      @title = @event.title
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def new
    if current_user
      @event = Event.new
      if @event.place_id.nil? == false
        begin
          place = Place.find(@event.place_id.to_s)
          @event.place_name = place.name
        rescue
        end
      else
        if current_user.places.count > 0
          @event.place_name = current_user.places.first.name
          @event.place_id = current_user.places.first.id.to_s
        end
      end
      @title = t('events.new_event')
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def create
    if current_user
      @event = Event.new
      @event.start = Date.new(params[:event][:"start(1i)"].to_i, params[:event][:"start(2i)"].to_i, params[:event][:"start(3i)"].to_i)
      @event.finish = Date.new(params[:event][:"finish(1i)"].to_i, params[:event][:"finish(2i)"].to_i, params[:event][:"finish(3i)"].to_i)
      @event.title = params[:event][:title]
      @event.description = params[:event][:description]
      @event.publish = params[:event][:publish]
      if params[:event][:place_id] == ""
        @place = Place.new
        @place.name = params[:event][:place_name]
        @place.street = params[:event][:place_street]
        @place.city = params[:event][:place_city]
        @place.country_id = params[:event][:place_country_id]
        @place.save
        @event.place = @place
      else
        @event.place_id = params[:event][:place_id]
      end
      @event.eventcategory_id = params[:event][:eventcategory_id]
      @event.user = current_user
      if @event.save
        redirect_to event_path(:id => @event.slug)
      else  
        respond_to do |format|
          format.html { render :action => 'new', :layout => 'main2' }
        end
      end
    else
      redirect_to :not_found
    end
  end

  def edit
    @event = Event.where(:slug => params[:id]).first
    begin
        # Getting the place name to fill it into the form
      if @event.place_id
        place = Place.find(@event.place_id)
        @event.place_name = place.name
      end
    rescue
    end
    if current_user and @event.nil? == false and @event.user_id == current_user.id
      @title = t('places.edit_place')
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def update
    @event = Event.where(:slug => params[:id]).first
    if current_user and @event.nil? == false and @event.user == current_user
      @event.start = Date.new(params[:event][:"start(1i)"].to_i, params[:event][:"start(2i)"].to_i, params[:event][:"start(3i)"].to_i)
      @event.finish = Date.new(params[:event][:"finish(1i)"].to_i, params[:event][:"finish(2i)"].to_i, params[:event][:"finish(3i)"].to_i)
      @event.title = params[:event][:title]
      @event.description = params[:event][:description]
      @event.publish = params[:event][:publish]
      @event.eventcategory_id = params[:event][:eventcategory_id]
      if params[:event][:place_id] == ""
        @place = Place.new
        @place.name = params[:event][:place_name]
        @place.street = params[:event][:place_street]
        @place.city = params[:event][:place_city]
        @place.country_id = params[:event][:place_country_id]
        @place.save
        @event.place = @place
      else
        @event.place_id = params[:event][:place_id]
      end
      if @event.save
        flash[:success] = t('places.success_edit')
        redirect_to event_path(:id => @event.slug)
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

  def delete
  end

  def destroy
  end

  def agenda
    #@agenda = Event.near([request.location.city, request.location.country].join(', ')).today
    if params[:location]
      @location = params[:location]
    else
      @location = [session[:location_city], session[:location_country]].join(', ')
    end
    #categories
    begin
      if params[:event]
        if params[:event][:eventcategory_id]
          category = Eventcategory.find(params[:event][:eventcategory_id])
        end
      end
      if params[:category]
        category = Eventcategory.where(:slug => params[:category]).first
      end
    rescue
      @category_id = ""
    end
    if category.nil?
      @category_id = ""
    else
      @category_id = category.id.to_s
    end
    
    if params[:day] and params[:month] and params[:year]
      if params[:day] != '_' and params[:month] != '_' and params[:year] != '_' and params[:day].class.to_s == 'Integer' and params[:month].class.to_s == 'Integer' and params[:year].class.to_s == 'Integer' 
        date_is = Date.new(params[:year], params[:month], params[:day])
        if @category_id == ""
          @agenda = Event.near(@location).where(:start.lte => date_is, :finish.gte => date_is).page(1).per(30)
        else
          @agenda = Event.near(@location).where(:start.lte => date_is, :finish.gte => date_is, :event_category_id => @category_id).page(1).per(30)
        end
      else
        if @category_id == ""
          @agenda = Event.near(@location).today.page(params[:page]).per(30)
        else
          @agenda = Event.near(@location).where(:eventcategory_id => @category_id).today.page(params[:page]).per(30)
        end
      end
    else
      if @category_id == ""
        @agenda = Event.near(@location).today.page(params[:page]).per(30)
      else
        @agenda = Event.near(@location).where(:eventcategory_id => @category_id).today.page(params[:page]).per(30)
      end
    end
    
    if params[:date]
      if params[:date][:day] and params[:date][:month] and params[:date][:year]
        begin
          date_is = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
          if @category_id == ""
            @agenda = Event.near(@location).where(:start.lte => date_is, :finish.gte => date_is).page(1).per(30)
          else
            @agenda = Event.near(@location).where(:start.lte => date_is, :finish.gte => date_is, :eventcategory_id => @category_id).page(1).per(30)
          end
        rescue
          if @category_id == ""
            @agenda = Event.near(@location).today.page(params[:page]).per(30)
          else
            @agenda = Event.near(@location).where(:eventcategory_id => @category_id).today.page(params[:page]).per(30)
          end
        end
      else
        if @category_id == ""
          @agenda = Event.near(@location).today.page(params[:page]).per(30)
        else
          @agenda = Event.near(@location).where(:eventcategory_id => @category_id).today.page(params[:page]).per(30)
        end
      end
    end
    
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end

end
