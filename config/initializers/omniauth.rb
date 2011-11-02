require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6DhR5c1RnOIDf9sKV4OLQ', 'bjzlJmly4XguH1GRFZzicBNOEyTF4CcF2pdwQA98y3k'
  provider :facebook, '195975813810721', '85ed4e013ded299d48d76dd82834410f', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :openid, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end