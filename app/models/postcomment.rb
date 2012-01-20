class Postcomment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :post
  belongs_to :user
  
  field :text,           :type => String
  
end
