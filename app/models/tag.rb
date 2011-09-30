class Tag
  include Mongoid::Document
  field :text, :type => String
  
  has_many :taggings, as: :taggable
  
  def self.findorcreate(text)
    text = text.downcase
    temp_tag = Tag.where(:text => text).first
    if temp_tag.nil? == true
      temp_tag = Tag.create!(:text => text)
    end
    return temp_tag
  end
end
