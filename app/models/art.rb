class Art
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  belongs_to :user
  belongs_to :category
  
  has_many :artcomments
  
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
  
  
  def other_art_of_user(limit)
    Art.where(:user_id => self.user.id.to_s).excludes(:id => self.id.to_s).limit(limit)
  end
end
