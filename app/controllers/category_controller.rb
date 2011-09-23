class CategoryController < ApplicationController
  def show
    @category = Category.where(:slug => params[:slug]).first
    @arts = Art.where(:category_id => @category.id.to_s).page(params[:page]).per(30)
    render :layout => 'main'
  end

end
