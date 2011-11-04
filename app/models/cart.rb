class Cart
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  has_many :items, :dependent => :destroy
  
end
