class Item
  include Mongoid::Document
  
  #after_save :crop_on_save
  after_update :crop_on_save
  
  field :height,       :type => Float
  field :width,        :type => Float
  
  field :media_id,     :type => Integer
  field :frame,        :type => Boolean
  field :frame_type,   :type => String
  
  field :orientation,  :type => String
  field :size,         :type => String
  
  field :x,            :type => Integer
  field :y,            :type => Integer
  field :w,            :type => Integer
  field :h,            :type => Integer

  field :custom_price, :type => Float
  field :fotolia_id,   :type => Integer
  
  field :price,        :type => Integer
  
  mount_uploader :crop,       CropUploader
  
  
  belongs_to :art
  belongs_to :cart
  
  def crop_on_save
    puts "estoy haciendo el crop"
    crop.recreate_versions! if x.present?
  end
end
