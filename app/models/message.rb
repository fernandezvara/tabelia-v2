class Message
  include Mongoid::Document

  field :readed,      type: Boolean, default: false
  field :in_reply_to, type: String
  
  belongs_to :mailfolder
  belongs_to :messageraw
end
