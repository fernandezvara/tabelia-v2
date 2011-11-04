class Item
  include Mongoid::Document
  
  field :height, :type => Float
  field :width,  :type => Float
  
  field :media_id, :type => Integer
  field :frame,    :type => Boolean
  
  field :price,  :type => Integer
  
  belongs_to :art
  belongs_to :cart
  
end
