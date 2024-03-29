# Be sure to restart your server when you modify this file.

# Tabelia::Application.config.session_store :cookie_store, key: '_tabelia_session'
  if Rails.env == "development"
    Tabelia::Application.config.session_store :redis_session_store
  else
    Tabelia::Application.config.session_store :redis_session_store, {
      :host => 'localhost',
      :port => 6379,
      :db => 3
    }
  end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Tabelia::Application.config.session_store :active_record_store
