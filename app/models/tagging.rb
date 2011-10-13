class Tagging
  include Mongoid::Document
  field :as, :type => String
  
  referenced_in :creator, :class_name => 'User'
  
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
  
  def self.of_object(obj)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id)
  end
  def self.of_object_as(obj, as)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :as => as)
  end
  def self.of_object_as_where_creator(obj, as, user)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :as => as, :creator_id => user.id)
  end
  
  def self.delete_all_tags_of_object(obj)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id).delete_all
  end
  
  def self.delete_all_tags_of_object_as(obj, as)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :as => as).delete_all
  end
  
  def self.delete_all_tags_of_object_as_where_creator(obj, as, user)
    return Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :as => as, :creator_id => user.id).delete_all
  end
  
  def self.delete_tag_of_object(obj, tag_text, as, user)
    tag = Tag.where(:text => tag_text).first
    if tag.nil? == true
      return false
    else
      if Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :as => as, :creator_id => user.id, :tag_id => tag.id).delete_all == 1
        return true
      else
        return false
      end
    end
  end
  
  def self.get_objects_with_tag(tag_text, as)
    tag = Tag.where(:text => tag_text).first
    if tag.nil? == true
      return []
    else
      taggings = Tagging.where(:as => as, :tag_id => tag.id)
      objects = Array.new
      taggings.each do |tagging|
        objects << tagging.taggable
      end
    end
  end
  
  def self.new_tag_for(obj, text, as, user)
    # si el tag que queremos crear ya existe le devolvemos, si no lo creamos, si hay un error en la creacion devolvemos false
    tag = Tag.findorcreate(text)
    tagging_temp = Tagging.where(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :tag_id => tag.id, :as => as, :creator_id => user.id).first
    if tagging_temp.nil? == true
      tagging_temp = Tagging.create(:taggable_type => obj.class.to_s, :taggable_id => obj.id, :tag_id => tag.id, :as => as, :creator_id => user.id)
    end
    if tagging_temp.nil?
      return false
    else
      return tagging_temp
    end
  end
end
