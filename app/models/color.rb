class Color
  include Mongoid::Document
  field :red, :type => Integer
  field :green, :type => Integer
  field :blue, :type => Integer
  field :rgb, :type => String
  
  index :red
  index :green
  index :blue
  
  index :rgb, :unique => true
  
  has_many :color_relations
  
  def self.near_colors(color, radius)
    # Color must not have the hash!!!!!!!
    color = color.gsub("#", "")
    arr_color = color.split("")
    red_hex = arr_color[0..1].join.to_i(16)
    green_hex = arr_color[2..3].join.to_i(16)
    blue_hex = arr_color[4..5].join.to_i(16)
    
    min_red = red_hex - radius
    max_red = red_hex + radius
    min_green = green_hex - radius
    max_green = green_hex + radius
    min_blue = blue_hex - radius
    max_blue = blue_hex + radius    
    
    colors = Color.any_in(:red => (min_red..max_red).to_a).any_in(:green => (min_green..max_green).to_a).any_in(:blue => (min_blue..max_blue).to_a)
        
    ids = Array.new
    colors.each do |color|
      ids << color.id.to_s
    end
    # remove duplicates... and return the relations
    return ColorRelation.any_in(:color_id => ids)
  end
  
  
  
  def self.findorcreate(rgb)
    rgb = rgb.downcase
    begin
      temp_color = Color.where(:rgb => rgb).first
    rescue
    end
    if temp_color.nil? == true
      temp_color = Color.new
      temp_color.rgb = rgb
      arr_rgb = rgb.split("")
      temp_color.red   = arr_rgb[1..2].join.to_i(16)
      temp_color.green = arr_rgb[3..4].join.to_i(16)
      temp_color.blue  = arr_rgb[5..6].join.to_i(16)
      temp_color.save
    end
    return temp_color
  end 
end
