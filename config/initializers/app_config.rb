

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

ActionMailer::Base.default_url_options[:host] = "192.168.1.73:3000"

# APP CONFIGURATION


# RESQUE CONFIGURATION