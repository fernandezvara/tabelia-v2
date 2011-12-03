class ArtSimilar
  include Mongoid::Document
  
  field :art_id,       type: String
  field :photo,        type: Boolean
  field :similar_id,   type: String
  field :why,          type: Integer
  
end