class Visit
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  field :visited_type
  field :visited_id
  field :visitor
  field :session_id
  field :from
  
end