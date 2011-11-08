class OrderController < ApplicationController
  def new
    @order = Order.new
    @order.user = current_user
    @details = EXPRESS_GATEWAY.details_for(params[:token])
    
    @order.token = @details.token
    #@order.payer = @details.payer if @details.payer.nil? == false
    @order.payer_id = @details.payer_id
    
    @order.status = 0  # not finished!
    
    @order.order_number = "#{Time.now.year} "
    @order.ip_address = request.remote_ip
    @order.save
    
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
      new_order_item = OrderItem.new
      new_order_item.order = @order
      new_order_item.height = item.height
      new_order_item.width = item.width
      new_order_item.item_user_amount = pay_user * 100
      new_order_item.item_tabelia_amount = pay_tabelia * 100
      new_order_item.media_id = item.media_id
      new_order_item.frame = item.frame
      new_order_item.art_id = item.art_id
      new_order_item.save!
    end
    
    @order.order_users_amount = @total_payment_users * 100
    @order.order_tabelia_amount = @total_payment_tabelia * 100
    @order.order_subtotal_amount = @subtotal_payment * 100
    @order.order_tax_amount = (@total_payment_tabelia * 100 * 0.18).round
    @order.order_total_amount = @order.order_subtotal_amount + @order.order_tax_amount
    
    @order.save
    
    respond_to do |format|
      format.html { render :layout => 'main' }
    end
  end

  def update
    @order = Order.where(:slug => params[:id]).first
    if @order.save
      if @order.purchase
        @current_cart = current_cart
        items = @current_cart.items
        items.each do |item|
          item.delete
        end
        render :action => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end
    
  end

  def success
  end

  def failure
  end

end
