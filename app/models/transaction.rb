class Transaction
  include Mongoid::Document
  
  belongs_to :order

  field :success,       :type => Boolean
  field :authorization, :type => String
  field :message,       :type => String
  field :params,        :type => String

  def response=(response)
    self.success       = response.success?
    self.authorization = response.authorization
    self.message       = response.message
    self.params        = response.params.to_s
  rescue ActiveMerchant::ActiveMerchantError => e
    self.success       = false
    self.authorization = nil
    self.message       = e.message
    self.params        = ''
  end
  
end
