CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAINIY3UUWJG5RZJSA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'assets2.tabelia.com'                     # required
  config.fog_host       = 'http://assets2.tabelia.com'            # optional, defaults to nil
  config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end