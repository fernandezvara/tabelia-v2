class Useractivity
  include Mongoid::Document
  
  embedded_in :user
  
  field :when, type: DateTime
  referenced_in :activity
  
end
