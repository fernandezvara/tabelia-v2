class Activitydata
  include Mongoid::Document
  
  embedded_in :activity
  
  field :key, type: String
  field :value, type: String
end
