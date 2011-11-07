class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :order_number,            :type => String
  
  field :payer_id,                :type => String
  field :payer,                   :type => String
  field :token,                   :type => String
  
  field :order_users_amount,      :type => Integer
  field :order_tabelia_amount,    :type => Integer
  field :order_transport_amount,  :type => Integer
  field :order_subtotal_amount,   :type => Integer
  field :order_tax_name,          :type => String
  field :order_tax_amount,        :type => Integer
  field :order_total_amount,      :type => Integer
  
  field :ip_address,              :type => String
  
  field :status,                  :type => Integer
  
  slug :order_number
  
  has_many :order_items
  
  has_many :transactions
  
  def purchase
    response = process_purchase
    transactions.create!(:action => "purchase", :amount => order_total_amount, :response => response)
    self.status = 1 if response.success?
    self.save if response.success?
    response.success?
  end
  
  def process_purchase
    EXPRESS_GATEWAY.purchase(order_total_amount, express_purchase_options)
  end
  
  def express_purchase_options
    {
      :currency          => 'EUR',
      :ip                => ip_address,
      :token             => token,
      :payer_id          => payer_id,
      :subtotal          => order_subtotal_amount,
      :shipping          => 0,
      :handling          => 0,
      :tax               => order_tax_amount
    }
  end
  
end
