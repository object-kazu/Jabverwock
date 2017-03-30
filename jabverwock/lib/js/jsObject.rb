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
    
    def initialize(*inits)
      super inits
      @doc = JsDocument.new()
      updateSelector inits
    end
    
    def updateSelector(*inits)
      setSelectors inits.flatten
      @doc.setSelectors inits.flatten
      self
    end

    def orders
      l = []
      l << @orders << @doc.orders 
      l.flatten
    end
    
  end


  # a = JsObject.new(:id__test)
  # p a.doc
  # p a.doc.byID.element
  # p a.orderList
  
end

