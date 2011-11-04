class CartController < ApplicationController
  def index
    @current_cart = current_cart
    @items = @current_cart.items
    
    # primero verificamos que haya sessión de usuario    
    if current_user
      @current_user = current_user
      @addresses = current_user.addresses
      
      if session[:delivery_address].nil? == true
        if @addresses.count > 0
          @delivery_address = @current_user.addresses.first
          session[:delivery_address] = @delivery_address.id.to_s
         else
           @delivery_address = nil
           session[:delivery_address] = nil
         end
      else 
        @delivery_address = Address.find(session[:delivery_address])
      end
      

      if session[:invoice_address].nil? == true 
        if @addresses.count > 0
          @invoice_address = @current_user.addresses.first
          session[:invoice_address] = @invoice_address.id.to_s
        else
          @invoice_address = nil
          session[:invoice_address] = nil
        end
      else
        @invoice_address = Address.find(session[:invoice_address])
      end
    end   
    
     
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
    
  end

  def price
    @art = Art.where(:slug => params[:art_id]).first
    @artist_price = @art.price.to_f
    @tabelia_price = @art.get_price(params[:height].to_f, params[:width].to_f, params[:media_id].to_i, params[:frame].to_i).to_f
    @total = @artist_price + @tabelia_price 
    
    respond_to do |format|
      format.js
    end
  end

  def create
    @item = Item.new(params[:item])
    @current_cart = current_cart
    if @item.save
      respond_to do |format|
        format.html { 
          redirect_to(cart_path, :notice => 'Item added correctly.') 
        }
      end
    end
  end

  def destroy
  end

end
