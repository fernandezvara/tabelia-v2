class OrderItem
  include Mongoid::Document
  
  field :height,                :type => Float
  field :width,                 :type => Float
  field :item_user_amount,      :type => Integer
  field :item_tabelia_amount,   :type => Integer
  field :media_id,              :type => Integer
  field :frame,                 :type => Boolean
  
  belongs_to :order
  belongs_to :art
  
end
