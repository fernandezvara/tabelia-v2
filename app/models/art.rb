class Art
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  belongs_to :user
  
  field :name,           :type => String,   :presence => true
  field :image,          :type => String
  field :price,          :type => Integer,  :presence => true
  field :max_height,     :type => Integer
  field :max_width,      :type => Integer
  field :description,    :type => String
  field :status,         :type => Integer
  field :accepted,       :type => Boolean
  field :original,       :type => String
  
  slug :name
  
  mount_uploader :image,    ImageUploader
  
end
