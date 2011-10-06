class Activity
  include Mongoid::Document
  
  field :what, type: String
  referenced_in :user
  field :when, type: DateTime
  
  field :to,       type: String
  field :art,      type: String
  field :comment,  type: String
end
