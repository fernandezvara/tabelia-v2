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

end
