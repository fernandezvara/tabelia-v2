class Art
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  attr_accessor :tags
  
  after_save :create_tags
  
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
    if limit == 0
      Art.where(:user_id => self.user.id.to_s).excludes(:id => self.id.to_s)
    else
      Art.where(:user_id => self.user.id.to_s).excludes(:id => self.id.to_s).limit(limit)
    end
  end
  
  private
  
  def create_tags
    Tagging.delete_all_tags_of_object_as_where_creator(self, 'arttag', self.user)
    tags_array = tags.split(',')
    tags_array.each do |tag|
      Tagging.new_tag_for(self, tag, 'arttag', self.user)
    end
  end
end
