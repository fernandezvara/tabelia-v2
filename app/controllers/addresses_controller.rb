class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    @address.user = current_user
    if @address.save
      @errors = false
      @current_cart = current_cart
      @items = @current_cart.items
      @addresses = current_user.addresses
      if session[:delivery_address].nil? == true and @addresses.count > 0
        @delivery_address = @current_user.addresses.first
        session[:delivery_address] = @delivery_address.id.to_s
      else
        @delivery_address = Address.find(session[:delivery_address])
      end
      if session[:invoice_address].nil? == true and @addresses.count > 0
        @invoice_address = @current_user.addresses.first
        session[:invoice_address] = @invoice_address.id.to_s
      else
        @invoice_address = Address.find(session[:invoice_address])
      end
    else
      @errors = true
    end

    respond_to do |format|
      format.js
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      @errors = false
    else
      @errors = true
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
  end

  def address
    @address_type = params[:type]
    if @address_type == 'delivery'
      @delivery_address = Address.find(params[:address])
      session[:delivery_address] = @delivery_address.id.to_s
    end
    if @address_type == 'invoice'
      @invoice_address = Address.find(params[:address])
      session[:invoice_address] = @invoice_address.id.to_s
    end

    respond_to do |format|
      format.js
    end
  end

end
