class MessagesController < ApplicationController
  def inbox
    @messages = current_user.inbox.messages.order_by(:created_at, :desc)
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

  def view
    @message = current_user.inbox.messages.find(params[:id])
    if @message.readed != true
      @message.readed = true
      @message.save
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
