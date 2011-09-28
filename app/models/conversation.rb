class Conversation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :readed,  type: Boolean, default: false

  belongs_to :user
  belongs_to :bucket

end
