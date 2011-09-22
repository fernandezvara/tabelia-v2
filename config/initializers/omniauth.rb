require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6DhR5c1RnOIDf9sKV4OLQ', 'bjzlJmly4XguH1GRFZzicBNOEyTF4CcF2pdwQA98y3k'
  provider :facebook, '238551882835713', 'a220ef46aef2dd0b6f38faf0152bba9b'
  provider :openid, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end