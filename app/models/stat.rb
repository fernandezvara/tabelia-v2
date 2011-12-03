class Stat
  include Mongoid::Document
  include Mongoid::Tracking
  
  field :st_type
  field :st_id
  
  track :visits       # visits for that day (User & Art)
  track :likes        # likes received that day (Art)
  track :unlikes
  track :follows      # follows received that day (User)
  track :unfollows
  track :comments     # comments received that day (User & Art)
  
  track :sells        # sells done that day (Art)
  
  track :popularity   # points of popularity for the given day

  field :popularity_today , :type => Float
  
  index(
    [
      [ :st_type, Mongo::ASCENDING ],
      [ :st_id, Mongo::ASCENDING ]
    ],
    unique: true, background: true
    )
    
  index :popularity_today
end
