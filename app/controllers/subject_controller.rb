class SubjectController < ApplicationController
  def show
    @subject = Subject.where(:slug => params[:slug]).first
    if @subject.nil? == true
      show_404
    else
      if current_user
        show_search_level = 1
      else
        show_search_level = 2
      end
      @search = Art.search do
        with(:photo, true)
        with(:show_search).greater_than(show_search_level)
        with(:subject_slug, params[:slug])
        with(:tecnique_slug, params[:tecnique]) if params[:tecnique]
        order_by(:name, :asc)
        paginate(:per_page => 30, :page => params[:page])
      end
      @arts = @search.results
      @title = @subject.name
      respond_to do |format|
        format.html { render :layout => 'main' }
        format.js
      end
    end
  end
end