class Gcomment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  field :text,           :type => String
  
end
