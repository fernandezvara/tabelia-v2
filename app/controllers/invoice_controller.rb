class InvoiceController < ApplicationController
  def show
    @order = Order.last
    
    respond_to do |format|
      format.pdf do 
        pdf = InvoicePdf.new(@order, view_context)
        send_data pdf.render, :filename => "#{@order.order_number}.pdf", :type => "application/pdf", :disposition => "inline"
      end
    end
  end

end
