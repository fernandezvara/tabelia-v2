class CartController < ApplicationController
  
  force_ssl
  
  def index
    @current_cart = current_cart
    @items = @current_cart.items
    
    @total_payment_users = 0.0
    @total_payment_tabelia = 0.0
    @total_payment_taxes = 0.0
    @subtotal_payment = 0.0
    @total_payment = 0.0
    
    @items.each do |item|
      pay_user = item.art.price.round(2)
      pay_tabelia = item.art.get_price(item.height, item.width, item.media_id, item.frame).round(2)
      @total_payment_users = (@total_payment_users + pay_user).round(2)
      @total_payment_tabelia = (@total_payment_tabelia + pay_tabelia).round(2)      
      @subtotal_payment = (@subtotal_payment + pay_user + pay_tabelia).round(2)
    end
    
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

    if @invoice_address
      @total_payment_taxes = Taxes.calculate(@invoice_address.country_id.upcase, @invoice_address.is_company, @subtotal_payment).round(2)
      @total_payment = (@subtotal_payment + @total_payment_taxes).round(2)
      # falta añadir transporte
    else
      @total_payment_taxes = 0
      @total_payment = @subtotal_payment
      # falta añadir transporte!
    end
    
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
    
  end

  def checkout
    @current_cart = current_cart
    @items = @current_cart.items
    
    @total_payment_users = 0.0
    @total_payment_tabelia = 0.0
    @total_payment_taxes = 0.0
    @subtotal_payment = 0.0
    @total_payment = 0.0

    paypal_items = Array.new
    
    @items.each do |item|
      pay_user = item.art.price.round(2)
      pay_tabelia = item.art.get_price(item.height, item.width, item.media_id, item.frame).round(2)
      @total_payment_users = (@total_payment_users + pay_user).round(2)
      @total_payment_tabelia = (@total_payment_tabelia + pay_tabelia).round(2)
      @subtotal_payment = (@subtotal_payment + pay_user + pay_tabelia).round(2)
      paypal_item = { 
        :name => item.art.name,
        :amount => ((pay_user + pay_tabelia) * 100).round,
        :url => art_profile_url(:slug => item.art.slug),
        :description => "(#{item.height}x#{item.width})"
        }
      paypal_items << paypal_item
    end
    
    #Taxes...
    @invoice_address = Address.find(session[:invoice_address])
    # falta añadir transporte!!!
    @total_payment_taxes = Taxes.calculate(@invoice_address.country_id.upcase, @invoice_address.is_company, @subtotal_payment).round(2)
    @total_payment = (@subtotal_payment + @total_payment_taxes).round(2)
    
    puts "subtotal: #{@subtotal_payment}"
    puts "taxes: #{@total_payment_taxes}"
    puts "total payment: #{@total_payment}"
    response = EXPRESS_GATEWAY.setup_purchase((@total_payment * 100).round,
        :currency          => 'EUR',
        :ip                => request.remote_ip,
        :return_url        => new_order_url,
        :cancel_return_url => cart_url,
        :no_shipping       => '1',
        :items             => paypal_items,
        :subtotal          => @subtotal_payment * 100,
        :shipping          => 0,
        :handling          => 0,
        :tax               => @total_payment_taxes * 100
      )
      redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    
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
