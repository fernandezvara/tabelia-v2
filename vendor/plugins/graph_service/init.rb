require "ostruct"

AppConfig = OpenStruct.new({
  :name => 'tabelia',
  :graph => OpenStruct.new({
    :server => 'http://localhost:9000'
  })
})


require File.join(File.dirname(__FILE__), 'client', 'client') 