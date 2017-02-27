require_relative "../global/globalDef" 

# require "global/globalDef"


module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsBase
    
    def initialize(id, cls, name)
      attrBaseInit(id,cls,name)
      @obj = ""
    end
    
    def attrBaseInit (id, cls, name)
      @id = id
      @cls = cls
      @name = name
    end
    
    
    
  end


   # a = JsBase.new("","","")
  
end

