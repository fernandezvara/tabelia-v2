class ColorRelation
  include Mongoid::Document
  
  belongs_to :color
  belongs_to :art
  
  index :art_id
  index :color_id
  
  def self.colors_of(art)
    return ColorRelation.where(:art_id => art.id)
  end
  
  def self.delete_colors_of(art)
    ColorRelation.where(:art_id => art.id).delete_all
  end
  
  def self.add_color_to(art, color)
    color_obj = Color.findorcreate(color)
    if ColorRelation.where(:art_id => art.id, :color_id => color_obj.id).count == 0
      new_relation = ColorRelation.create!(:art => art, :color => color_obj)
    end
  end
end
