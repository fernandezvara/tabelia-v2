class CommentsController < ApplicationController
  def create
    if current_user
      begin
        @user = User.where(:username => params[:username]).first
        @comment = Comment.new
        @comment.author = current_user
        @comment.receiver = @user
        @comment.text = params[:text]
        
        @comment.save!
      rescue
        
      end
    end
  end


  def view
    if current_user
      begin
        @user = User.where(:username => params[:username]).first
        @comments = @user.comments_received.order_by(:created_at, :desc).where(:created_at.lte => Time.at(params[:last].to_i)).limit(10)
        if @comments.count < 10
          @nolink = true
        else
          @nolink = false
          @last_comment_time = @comments.last.created_at.to_i
        end
      rescue
      end
    end
  end

end
