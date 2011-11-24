class CategoryController < ApplicationController
  def show
    @category = Category.where(:slug => params[:slug]).first
    if @category.nil? == true
      show_404
    else
      if current_user
        show_search_level = 1
      else
        show_search_level = 2
      end
      @search = Art.search do
        with(:show_search).greater_than(show_search_level)
        with(:category_slug, params[:slug])
        order_by(:name, :asc)
        paginate(:per_page => 30, :page => params[:page])
      end
      @arts = @search.results
      @title = @category.name
      respond_to do |format|
        format.html { render :layout => 'main' }
        format.js
      end
    end
  end

end
