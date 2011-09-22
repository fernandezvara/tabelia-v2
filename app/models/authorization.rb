class Authorization
  include Mongoid::Document
  
  belongs_to :user
end
