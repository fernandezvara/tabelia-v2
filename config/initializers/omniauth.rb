Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'bqe8mTvQ0eBsLr3jHTkg', 'TBWeoQoVXWGshRNaRdu9VyzeX12BzQsHMZVaK5wLt4'
  provider :facebook, '195975813810721', '85ed4e013ded299d48d76dd82834410f', { 
    :client_options => { 
      :ssl => { :ca_path => "/etc/ssl/certs" }
      },
    :scope => 'publish_stream,offline_access,email' 
    }
  provider :google_oauth2, '735261672762.apps.googleusercontent.com', 'KJedQIl6iTHiMJd98B8M6Jkv', {
      :scope => 'https://www.googleapis.com/auth/plus.me'
    }
end


#provider :facebook, APP_ID, APP_SECRET, {:scope => 'publish_stream,offline_access,email'}

# https://www.googleapis.com/auth/plus.me
# https://www.googleapis.com/oauth2/v1/userinfo
# https://www.googleapis.com/auth/userinfo.profile