class Image
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  
  field  :title,       :type => String
  field  :description, :type => String
  
  mount_uploader :image, Image1Uploader
  
  validates_presence_of :title
  
  slug :title
  
  belongs_to :imageable, :polymorphic => true
  
end
