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
    @user = User.where(:username => params[:username]).first
    if @user.nil?
      redirect_to :root
    end
  end

  def create
    puts params.inspect
    
    @user = User.where(:username => params[:username]).first
    if @user.nil? == true and current_user
      redirect_to :root
    else
      @message = Message.new
      @message.sender = current_user
      @message.text = params[:text]
      # TODO : LET USERS SEND MESSAGES TO MORE THAN ONE PERSON!!!
      if @message.send!([@user], params[:subject]) == true
        @flash_message = "Mensaje enviado correctamente."
        @flash_type = "success"
      else
        @flash_message = "Error enviando el mensaje, por favor, inténtalo más tarde."
        @flash_type = "error"
      end
    end
  end
  
  def delete
    begin
      @conversation = Conversation.where(:slug => params[:slug]).first
      relation = Userconversation.where(:user_id => current_user.id.to_s, :conversation_id => @conversation.id.to_s)
      
      # be sure this conversation belongs to this user....
      if relation.count == 1 and @conversation.nil? == false
        relation_to_change = relation.first
        relation_to_change.hide = true
        if relation_to_change.save!
          @flash_message = "Mensaje borrado."
          @flash_type = "success"
        else
          @flash_message = "Error borrando el mensaje."
          @flash_type = "error"
        end
      else
        @flash_message = "Error borrando el mensaje."
        @flash_type = "error"
      end
    rescue
      @flash_message = "Error borrando el mensaje."
      @flash_type = "error"
    end
  end
    
  def delete_from_view
    begin
      @conversation = Conversation.where(:slug => params[:slug]).first
      relation = Userconversation.where(:user_id => current_user.id.to_s, :conversation_id => @conversation.id.to_s)
      # be sure this conversation belongs to this user....
      if relation.count == 1 and @conversation.nil? == false
        relation_to_change = relation.first
        relation_to_change.hide = true
        if relation_to_change.save!
          flash[:success] = "Mensaje '#{@conversation.subject}' borrado."
        else
          flash[:error] = "Error borrando el mensaje."
        end
        redirect_to inbox_path
      else
        flash[:error] = "Error borrando el mensaje."
        redirect_to inbox_path
      end
    rescue
      flash[:error] = "Error borrando el mensaje."
      redirect_to inbox_path
    end
  end
end
