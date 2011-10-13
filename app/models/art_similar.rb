class ArtSimilar
  include Mongoid::Document
  
  field :art_id,       type: String
  field :similar_id,   type: String
  field :why,          type: Integer
  
end