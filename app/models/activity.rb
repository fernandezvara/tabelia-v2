class Activity
  include Mongoid::Document
  
  field :what, type: String
  referenced_in :user
  field :when, type: DateTime
  
  embeds_many :activitydatas
end
