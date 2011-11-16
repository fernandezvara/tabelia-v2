class Authorization
  include Mongoid::Document
  
  belongs_to :user
  
  field :provider,    :type => String
  field :uid,         :type => String
  field :fb_token,    :type => String
  field :fb_secret,   :type => String
  field :fb_username, :type => String
  field :tw_token,    :type => String
  field :tw_secret,   :type => String
  field :tw_username, :type => String
end
