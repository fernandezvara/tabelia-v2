class Color
  include Mongoid::Document
  field :red, :type => Integer
  field :green, :type => Integer
  field :blue, :type => Integer
  field :rgb, :type => String
  
  index :rgb, :unique => true
  
  has_many :color_relations
  
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
