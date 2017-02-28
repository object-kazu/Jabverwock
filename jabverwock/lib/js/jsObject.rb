if $FOR_GEM
  require "global/globalDef"
  require "js/jsDocument"
  require "js/jsBase"
  
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsDocument"
  require_relative "./jsBase"

end





module Jabverwock
  using StringExtension
  using ArrayExtension
  
  class JsObject < JsBase
           
    attr_accessor :doc
    
    def initialize(id, cls, name)
      super
      @doc
      attrInit(id, cls, name)
      
    end
    
    def attrInit(id, cls, name)
      attrBaseInit(id, cls, name)
      @doc = JsDocument.new(@id, @cls, @name)
    end
    
    
    
  end


  # a = JsObject.new("","","")
  # p a.doc
  # p a.doc.byID
  
  
end

