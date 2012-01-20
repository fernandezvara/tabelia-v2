class EventsController < ApplicationController
  def index
    if current_user
      @events = current_user.events.order_by(:start, :desc).page(params[:page]).per(30)
      @title = t("events.index.title")
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def show
  end

  def new
    if current_user
      @event = Event.new
      @title = t('events.new_event')
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def agenda
  end

end
