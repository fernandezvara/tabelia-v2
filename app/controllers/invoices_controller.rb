class InvoicesController < ApplicationController
  def index
    if current_user
      @invoices = current_user.invoices.order_by(:updated_at, :desc)
      render :layout => 'main'
    else
      redirect_to :root
    end
  end

  def show
    if current_user
      @invoice = current_user.invoices.where(:number => params[:number]).order_by(:updated_at, :desc)
      if @invoice.nil? == true
        redirect_to my_invoices_path
      else
        render :layout => 'main'
      end
    else
      redirect_to :root
    end
  end

  def receipt
  end

end
