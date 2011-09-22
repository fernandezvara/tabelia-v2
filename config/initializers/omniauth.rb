require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ZLhrmF6602zVn91rGclYg', 'SQ23o6E0VaIvucgcUtddEV8nxYkY7OnBExF0BLCANp0'
  provider :facebook, '238551882835713', 'a220ef46aef2dd0b6f38faf0152bba9b'
  provider :openid, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end