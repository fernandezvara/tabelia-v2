class PagesController < ApplicationController
  def index
    if current_user
      @cache = "front-page-logged-#{rand(10)}"
      puts @cache
      if fragment_exist?(@cache) == false
        @search = Art.search do
           with(:show_search).greater_than(1)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
      end
      respond_to do |format|
        format.html { render :layout => 'splash' }
      end
    else
      @cache = "front-non-logged-#{rand(10)}"
      puts "******************* @cache = #{@cache}"
      if fragment_exist?(@cache) == false
        @search = Art.search do
           with(:show_search).greater_than(2)
           paginate(:per_page => 40, :page => 1)
           order_by(:random)
         end
         puts "*****************Resultados: #{@search.results.count}"
      end
      
      respond_to do |format|
        format.html { render  'notloggedin', :layout => 'first_page' }
      end
    end
  end

  def help
  end

  def notloggedin
  end

  def not_found
    respond_to do |format|
      format.html do
        render :layout => 'main'
      end
    end
  end

end
