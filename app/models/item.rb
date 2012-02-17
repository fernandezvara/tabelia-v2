class Item
  include Mongoid::Document
  
  field :height, :type => Float
  field :width,  :type => Float
  
  field :media_id, :type => Integer
  field :frame,    :type => Boolean
  field :frame_type, :type => String
  
  field :orientation, :type => String
  field :size, :type => String
  
  field :x, :type => Integer
  field :y, :type => Integer
  field :w, :type => Integer
  field :h, :type => Integer

  field :custom_price, :type => Float
  field :fotolia_id, :type => Integer
  
  field :price,  :type => Integer
  
  mount_uploader :crop,       CropUploader
  
  belongs_to :art
  belongs_to :cart
  
end
