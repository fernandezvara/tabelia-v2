class Invoicestatus
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :invoice
  
  field :status, :type => Integer
  field :message_customer, :type => String
  field :message_internal, :type => String 
  
  index :invoice_id
  
end
