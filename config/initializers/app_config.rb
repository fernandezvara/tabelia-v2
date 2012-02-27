# SUNSPOT - DID YOU MEAN???
require "#{Rails.root}/extras/sunspot_did_you_mean"

# LANGUAGE

LANGUAGES = { 
  :en => 'English',
  :es => 'Castellano' 
  }
  
I18n.available_locales= [:en, :es]

#Juggernaut config
#if Rails.env == 'development'
  Juggernaut.url = "localhost:6379"
#else
#  Juggernaut.url = "server5-data.retocontinuo.local"
#end


# MAIL CONFIGURATION
ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => 'AKIAINIY3UUWJG5RZJSA',
  :secret_access_key => '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'


#ActionMailer::Base.smtp_settings = {
#  :address              => "smtp.gmail.com",
#  :port                 => 587,
#  :domain               => "cosmeticanatural.com",
#  :user_name            => "antonio@cosmeticanatural.com",
#  :password             => "Enertia22",
#  :authentication       => "plain",
#  :enable_starttls_auto => true
#}

ActionMailer::Base.default_url_options[:host] = "www.tabelia.com"

# APP CONFIGURATION


# RESQUE CONFIGURATION