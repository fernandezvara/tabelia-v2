class Invoice
  include Mongoid::Document
  include Mongoid::Timestamps
  
  auto_increment :number
  
  has_one :order
  
  field :status, :type => Integer
  
  has_many :invoicestatuses
  
  belongs_to :user
  
  index :number
  
end
