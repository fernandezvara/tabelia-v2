#encoding: UTF-8
class PostsController < ApplicationController
  def index
    if current_user
      @posts = current_user.posts.page(params[:page]).per(30)
      @title = t("articles.index.title")
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def show
    @post = Post.where(:slug => params[:slug]).first
    if @post.nil? == false
      @title = @post.title
      @user = @post.user
    end
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end

  def category
    @category = Postcategory.where(:slug => params[:category]).first
    if @category.nil? == false
      
        
      if current_user
        show_search_level = 1
      else
        show_search_level = 2
      end
       
    
      @search = Sunspot.search(Post) do
        with :category_slug, params[:category]
        with(:tabelia, params[:who]) if params[:who].present? and params[:who] != '_' and params[:who] != 'all'
        with(:show_search).greater_than(show_search_level)
        with(:language, params[:lang]) if params[:lang].present? and params[:lang] != '_' and params[:lang] != 'all'
        order_by :created_at, :desc
        paginate(:per_page => 3, :page => params[:page])
      end

      @posts = @search.results
      puts " ----------- @posts = #{@posts.count}"
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      redirect_to :not_found
    end
  end

  def new
    if current_user
      @post = Post.new
      @title = t('articles.new_article')
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def create
    if current_user
      @post = Post.new(params[:post])
      @post.slug = nil
      @post.user = current_user
      if params[:post][:language].nil?
        @post.language = current_user.language
      end
    
      respond_to do |format|
        if @post.save
          flash[:success] = t('articles.article_created_correctly')
          format.html { redirect_to(posts_path) }
        else
          flash.now[:error] = t('articles.fix_errors')
          format.html { render :action => "new", :layout => 'main2' }
        end
      end
    else
      redirect_to :not_found
    end
  end

  def edit
    @post = Post.where(:slug => params[:slug]).first
    if current_user and @post.user == current_user and @post.nil? == false
      @title = t('articles.edit_article') + ' · ' + @post.title
      respond_to do |format|
        format.html { render :layout => 'main2' }
      end
    else
      redirect_to :not_found
    end
  end

  def update
    @post = Post.where(:slug => params[:id]).first
    if current_user and @post.user == current_user and @post.nil? == false
      @title = t('articles.edit_article') + ' · ' + @post.title
      respond_to do |format|
        if @post.update_attributes(params[:post])
          flash[:success] =t('articles.article_edited_correctly')
          format.html { redirect_to(posts_path) }
        else
          flash.now[:error] = t('articles.fix_errors')
          format.html { render :action => "edit", :layout => 'main2' }
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

end
