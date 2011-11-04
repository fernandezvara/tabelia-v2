class Address
  include Mongoid::Document

  field :address_name,  :type => String,   :presence => true
  field :fullname,      :type => String,   :presence => true
  field :address_line1, :type => String,   :presence => true
  field :address_line2, :type => String
  field :city,          :type => String,   :presence => true
  field :county,        :type => String,   :presence => true
  field :postalcode,    :type => String,   :presence => true
  
  validates_presence_of :address_name
  validates_presence_of :fullname
  validates_presence_of :address_line1
  validates_presence_of :city
  validates_presence_of :postalcode
  validates_presence_of :country_id

  belongs_to :country
  belongs_to :user

end
