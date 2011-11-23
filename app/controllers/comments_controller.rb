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
        # delete caches
        expire_fragment("comments-user-#{@user.id.to_s}-#{session[:locale].to_s}") if fragment_exist?("comments-user-#{@user.id.to_s}-#{session[:locale].to_s}") == true
        data = Hash.new
        data['data'] = Hash.new
        data['who'] = current_user.id.to_s
        data['when'] = Time.now
        data['what'] = "cou"
        data['to'] = @user.id.to_s
        data['comment'] = @comment.id.to_s
        Resque.enqueue(Notificator, data)
      rescue
        
      end
    end
  end

  def view
    if current_user
      begin
        @user = User.where(:username => params[:username]).first
        @comments = @user.comments_received
          .order_by(:created_at, :desc)
          .where(:created_at.lte => Time.at(params[:last].to_i))
          .limit(10)
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

  def create_art
    if current_user
      begin
        @art = Art.where(:slug => params[:slug]).first
        @comment = Artcomment.new
        @comment.user = current_user
        @comment.art = @art
        @comment.text = params[:text]
        @comment.save!
        #delete art comment cache
        expire_fragment("comments-art-#{@art.id.to_s}-#{session[:locale].to_s}") if fragment_exist?("comments-art-#{@art.id.to_s}-#{session[:locale].to_s}") == true
        data = Hash.new
        data['who'] = current_user.id.to_s
        data['when'] = Time.now
        data['what'] = "coa"
        data['art'] = @art.id.to_s
        data['comment'] = @comment.id.to_s
        Resque.enqueue(Notificator, data)
      rescue
        
      end
    end
  end

  def view_art
    if current_user
      begin
        @art = Art.where(:slug => params[:slug]).first
        @comments = @art.artcomments
          .order_by(:created_at, :desc)
          .where(:created_at.lte => Time.at(params[:last].to_i))
          .limit(10)
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
