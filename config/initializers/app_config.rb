# SUNSPOT - DID YOU MEAN???
require "#{Rails.root}/extras/sunspot_did_you_mean"

# LANGUAGE

LANGUAGES = { 
  :en => 'English',
  :es => 'Castellano' 
  }
  
I18n.available_locales= [:en, :es]


# MAIL CONFIGURATION
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "cosmeticanatural.com",
  :user_name            => "antonio@cosmeticanatural.com",
  :password             => "Enertia22",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "www.tabelia.com"

# APP CONFIGURATION


# RESQUE CONFIGURATION