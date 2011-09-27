class MessagesController < ApplicationController
  def inbox
    
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

  def outbox
  end

  def notifications
  end

  def new
  end

  def create
  end

  def reply
  end

end
