class Recommendation
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  field :user_id
  field :what
  field :item_type
  field :item_id
  field :why,          type: Integer
  field :seen,         type: Boolean, default: false
  
end
