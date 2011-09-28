class MessagesController < ApplicationController
  
  def inbox
    @conversations = current_user.conversations.order_by(:updated_at, :desc)
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end
  
  def inbox_old
    @messages = current_user.inbox.messages.order_by(:updated_at, :desc)
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

  def view_old
    @message = current_user.inbox.messages.find(params[:id])
    if @message.readed != true
      @message.readed = true
      @message.save
    end
    @array_conversation = Array.new
    finish = false
    @temp_message = @message.messageraw
    while finish == false do
      if @temp_message.in_reply_to == nil
        finish = true
      else
        @new_message = @temp_message
        @temp_message = Messageraw.find(@new_message.in_reply_to)
        @array_conversation << @temp_message
      end
    end
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

  def reply_old
    @message = current_user.inbox.messages.find(params[:id])
    if @message.messageraw.receiver == current_user
      send_to =  @message.messageraw.sender
    else
      send_to = @message.messageraw.receiver
    end
    @reply = Messageraw.new
    @reply.sender = current_user
    @reply.receiver = send_to
    @reply.in_reply_to = @message.messageraw.id.to_s
    @reply.original_message = @message.messageraw.original_message
    @reply.subject = @message.messageraw.subject
    @reply.text = params[:text]
    @reply.send!
    
    puts receiver = "RECEIVER: #{send_to.name}"
    flash[:success] = "Mensaje enviado correctamente."
    redirect_to inbox_path
  end

  def outbox
  end

  def notifications
  end

  def new
  end

  def create
    @message = Messageraw.new
    @message.sender = current_user
    @message.receiver = User.where(:username => params[:username]).first
    @message.subject = params[:subject]
    @message.text = params[:text]
    @message.send!
    @message.original_message = @message.id.to_s
    @message.save!
    flash[:success] = "Mensaje enviado correctamente."
  end



end
