class Country
  include Mongoid::Document
  
  field :code,              :type => String  # ISO code
  field :name,    :type => String, :localize => true
  
  field :accept_send,       :type => Boolean
  field :accept_user,       :type => Boolean
  
  key :code
  
  has_many :addresses
  
  scope :in_locale, ->(locale) { 
      I18n.with_locale(locale) { self }
  }
  
  scope :allowed_to_send , where(:accept_send => true)
  scope :allowed_to_user , where(:accept_user => true)
  
end
