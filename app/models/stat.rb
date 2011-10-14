class Stat
  include Mongoid::Document
  include Mongoid::Tracking
  
  belongs_to :item, polymorphic: true
  
  track :visits       # visits for that day (User & Art)
  track :likes        # likes received that day (Art)
  
  track :forwards     # forwards received that day (User)
  
  track :comments     # comments received that day (User & Art)
  
  track :sells        # sells done that day (Art)
  
  track :popularity   # points of popularity for the given day
  
  index(
    [
      [ :item_type, Mongo::ASCENDING ],
      [ :item_id, Mongo::ASCENDING ]
    ],
    unique: true, background: true
    )
end
