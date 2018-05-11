require "global/globalDef"
require "global/jwOrigin"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class express multi line html tag, like head, body etc.
  class JWMulti < JWOrigin
    def initialize(style=$MULTI)
      super

    end    
  end 
end
