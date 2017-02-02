require "jabverwock/version"
require "global/globalDef"

module Jabverwock
  class << self
 
    def callMe
      p "Hello, my name is Jabverwock! #{$RET}"
      p "version is #{VERSION}"
    end
    
  end   
end
