require "ostruct"

AppConfig = OpenStruct.new({
  :name => 'tabelia',
  :graph => OpenStruct.new({
    :server => 'http://localhost:9000'
  })
})

APP_CONFIG = AppConfig