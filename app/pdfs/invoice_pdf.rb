# encoding: utf-8
class InvoicePdf < Prawn::Document
  
  def initialize(order, view)
    super(:top_margin => 70)
    @order = order
    @view = view
    invoice_top
    invoice_addresses
    invoice_items
    invoice_totals      
  end
  
  def invoice_top
    table(top_rows, :column_widths => [260,260]) do
      column(0..1).borders = []
      row(0).background_color = "c20000"
      column(1).text_color = "ffffff"
      column(1).align = :right
      column(1).size = 14
      column(1).font_style = :bold
      column(1).valign = :center
      column(1).padding = [0,30,0,30]
    end
  end
  
  def top_rows
    image = open("#{Rails.root}/app/assets/images/logo.png")
    [[{:image => image}, order_number]]
  end
  
  def order_number
    "Factura #{@order.slug}" #, :size => 24, :style => :bold
  end
  
  def invoice_addresses
    move_down 30
    table(addresses_rows, :column_widths => [220,80,220], :width => 520) do
      row(0).borders = []
      column(1).borders = []
      row(0).background_color = "ffffff"
      #row(0).padding = 5
    end
  end
  
  def addresses_rows
    [
      ["Shipping Address", "", "Invoice Address"], 
      [shipping_address, "", invoice_address]
    ]
  end
  
  def shipping_address
    shipping_address_array = shipping_address_table
    make_table(shipping_address_array, :width => 220, :cell_style => { :borders => [] }) do
      column(0).align = :left
      column(0).padding = [2, 5, 2, 5]
      row(0).font_style = :bold
      row(1..shipping_address_array.count).size = 8
    end
  end
  
  def shipping_address_table
    [
      ["Name"],
      ["Street"],
      ["City"]
    ]
  end
  
  def invoice_address
    invoice_address_array = invoice_address_table
    make_table(invoice_address_array, :width => 220, :cell_style => { :borders => [] }) do
      column(0).align = :left
      column(0).padding = [2, 5, 2, 5]
      row(0).font_style = :bold
      row(1..invoice_address_array.count).size = 8
    end
  end
  
  def invoice_address_table
    [['1'], ['2'], ['3']]
  end
  
  def invoice_items
    move_down 30
    table(table_rows, :column_widths => [420,100], :cell_style => { :borders => [:top, :bottom, :left, :right], :border_width => 0.3 }) do
      column(1).align = :right
      row(0).font_style = :bold
      row(0).align = :center
      self.header = true
    end
  end
  
  def table_rows
    rows = [['Producto', 'Precio']]
    @order.order_items.map do |item|
      rows << [item_details(item), price(item.item_tabelia_amount)]
    end
    rows
  end
  
  def item_details(item)
    make_table(item_details_inner(item), :width => 420) do
      row(0).font_style = :bold
      row(0).height = 24
      row(1..2).size = 9
      row(1..2).height = 12
      row(1..2).padding = [0,6,0,6]
      column(0).borders = []
    end
  end
  
  def item_details_inner(item)
    case item.media_id
    when 1
      media_txt = 'Canvas'
    when 2
      media_txt = 'Artistic'
    end
         
    if item.frame == true
      frame_txt = "Framed"
    else
      frame_txt = "No frame"
    end
    [["#{item.art.name}"], ["Size (HxW): #{item.height}x#{item.width} cm."], ["Media: #{media_txt} · #{frame_txt}"]]
  end
  
  def invoice_totals
    move_down 5
    table(total_rows, :column_widths => [420,100]) do
      column(0).font_style = :bold
      column(0..1).align= :right
      column(0..1).borders = []
      self.header = false
    end
  end
  
  def total_rows
    rows = 
      ['Item/s', price(@order.order_tabelia_amount.to_i)],
      ['Shipping & Handling', price(@order.order_transport_amount.to_i)]
    if @order.order_tax_amount > 0
      rows << [@order.order_tax_name, price(@order.order_tax_amount.to_i)]
    end
    rows << ['Total', price(@order.order_total_amount)]
    rows
  end
  
  def price(number)
    if number.nil?
      @view.number_to_currency(0, :unit => '€')
    else
      @view.number_to_currency(number.to_i / 100.0, :unit => '€')
    end
  end
end