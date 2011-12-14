class OrderController < ApplicationController
  def new
    @order = Order.new
    @order.user = current_user
    @order.delivery_address_id = session[:delivery_address]
    @order.invoice_address_id = session[:invoice_address]
    
    @invoice_address = Address.find(session[:invoice_address])
    
    @details = EXPRESS_GATEWAY.details_for(params[:token])
    
    @order.token = @details.token
    #@order.payer = @details.payer if @details.payer.nil? == false
    @order.payer_id = @details.payer_id
    
    @order.ip_address = request.remote_ip

    @order.save  # Saving the order with the details, next save the items on the order
    
    @current_cart = current_cart
    @items = @current_cart.items
    
    @total_payment_users = 0.0
    @total_payment_tabelia = 0.0
    @total_payment_transport = 0.0
    @total_payment_taxes = 0.0
    @subtotal_payment = 0.0
    @total_payment = 0.0
    
    @items.each do |item|
      pay_user = item.art.price.round(2)
      pay_tabelia = item.art.get_price(item.height, item.width, item.media_id, item.frame).round(2)
      @total_payment_users = (@total_payment_users + pay_user).round(2)
      @total_payment_tabelia = (@total_payment_tabelia + pay_tabelia).round(2)      
      @subtotal_payment = (@subtotal_payment + pay_user + pay_tabelia).round(2)
      if item.frame == 1
        framed = true
      else
        framed = false
      end
      country_id = @invoice_address.country_id.upcase
      pay_transport = Transport.calculate_size('DE', item.height, item.width, framed)
      @total_payment_transport = @total_payment_transport + pay_transport
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
    @order.order_tax_amount = (Taxes.calculate(@invoice_address.country_id.upcase, @invoice_address.is_company, @subtotal_payment).round(2) * 100).round
    @order.order_transport_amount = (@total_payment_transport * 100).round + (Taxes.calculate(@invoice_address.country_id.upcase, @invoice_address.is_company, @total_payment_transport).round(2) * 100).round
    @order.order_total_amount = @order.order_subtotal_amount + @order.order_tax_amount + @order.order_transport_amount
    
    @order.save
    if @order.purchase
      @current_cart = current_cart
      items = @current_cart.items
      items.each do |item|
        item.delete
      end
      invoice = Invoice.new
      #invoice.order = @order
      invoice.status = 1
      invoice.user = current_user
      invoice.save
      @order.invoice = invoice
      @order.save
      invoice_status = Invoicestatus.new
      invoice_status.status = 1
      invoice_status.invoice = invoice
      invoice_status.save
      #Resque.enqueue(NewOrderConfirmation, invoice.id.to_s)
      #Resque.enqueue(YourItemWasSold, invoice.id.to_s)
      respond_to do |format|
        format.html { render :layout => 'main' }
      end
    else
      respond_to do |format|
        format.html { render :action => "failure", :layout => 'main' }
      end
    end
    
  end

  def update
    @order = Order.find(params[:id])
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
