# encoding: UTF-8
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

  def view
    begin
      @conversation = Conversation.where(:slug => params[:slug]).first
      relation = Userconversation.where(:user_id => current_user.id.to_s, :conversation_id => @conversation.id.to_s).count
    
      # be sure this conversation belongs to this user....
      if relation == 1 and @conversation.nil? == false
        @conversation.read!(current_user)
        respond_to do |format|
          format.html { render :layout => 'main' }
          format.js
        end
      else
        redirect_to :root
      end
    rescue
      redirect_to :root
    end
  end

  def reply
    begin
      @conversation = Conversation.where(:slug => params[:slug]).first
      relation = Userconversation.where(:user_id => current_user.id.to_s, :conversation_id => @conversation.id.to_s).count
      
      # be sure this conversation belongs to this user....
      if relation == 1 and @conversation.nil? == false
        @message = Message.new
        @message.text = params[:text]
        @message.sender = current_user
        if @message.reply!(@conversation) == true
          flash[:success] = "Mensaje enviado correctamente."
          redirect_to inbox_path
        else
          flash[:error] = "Error al enviar el mensaje. Intentalo más tarde."
          redirect_to inbox_path
        end
      else
        redirect_to :root
      end
    
    rescue
      redirect_to :root
    end
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
