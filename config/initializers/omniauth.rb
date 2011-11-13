Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ZKnXYTs819Coqc6RuPC6Ag', 'zGvOKVnJ6euDGguqL87aaK79SpU9xb71me8TRuzbM'
  provider :facebook, '195975813810721', '85ed4e013ded299d48d76dd82834410f', { 
    :client_options => { 
      :ssl => { :ca_path => "/etc/ssl/certs" }
      }
    }
  provider :google_oauth2, '735261672762.apps.googleusercontent.com', 'KJedQIl6iTHiMJd98B8M6Jkv', {
      :scope => 'https://www.googleapis.com/auth/userinfo.profile'
    }
end

# https://www.googleapis.com/auth/plus.me
# https://www.googleapis.com/oauth2/v1/userinfo
# https://www.googleapis.com/auth/userinfo.profile