class Backwardlike
  include Mongoid::Document
  
  field :oo
  field :oi
  field :do
  field :di
  field :at, type: DateTime
  
end