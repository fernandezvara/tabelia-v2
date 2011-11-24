class SearchController < ApplicationController
  def index
    @keywords = params[:search]
    
    if current_user
      show_search_level = 1
    else
      show_search_level = 2
    end
    
    if params[:type].present? == true
      case params[:type]
      when 'user'
        @search = User.search do
          fulltext params[:search]
          spellcheck
          with(:show_search).greater_than(show_search_level)
          paginate(:per_page => 30, :page => params[:page])
        end
      when 'art'
        @search = Art.search do
          fulltext params[:search] do
            highlight :name
          end
          spellcheck
          with(:show_search).greater_than(show_search_level)
          with(:category_slug, params[:category]) if params[:category].present?
          paginate(:per_page => 30, :page => params[:page])
        end
      else
        @search = Sunspot.search(User, Art) do
          fulltext params[:search] do
            highlight :name
          end
          spellcheck
          with(:show_search).greater_than(show_search_level)
          paginate(:per_page => 30, :page => params[:page])
        end
      end
    else    
      @search = Sunspot.search(User, Art) do
        fulltext params[:search].to_ascii do
          highlight :name
        end
        spellcheck
        with(:show_search).greater_than(show_search_level)
        paginate(:per_page => 30, :page => params[:page])
      end
    end
    
    @title = t('search.search')
    
    @items = @search.results
    respond_to do |format|
      format.html { render :layout => 'main' }
      format.js
    end
  end

end
