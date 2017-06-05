if $FOR_GEM
  require "global/globalDef"
  require "js/jsDocument"
  require "js/jsBase"
  require "js/jsFunction"
  require "js/jsVar"
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsDocument"
  require_relative "./jsBase"
  require_relative "./jsFunction"
  require_relative "./jsVar"


end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is JS main
  class JsObject < JsBase
           
    attr_accessor :doc, :func, :var
    
    def initialize(*inits)
      super inits
      @doc = JsDocument.new
      @func = JsFunction.new
      @var = JsVar.new

      # @read = JsFileReader.new
      
      updateSelector inits
    end

    
    ######## function ###########
    
    
    ######## doc ###########
    def updateSelector(*inits)
      setSelectors inits.flatten
      @doc.setSelectors inits.flatten
      self
    end
    
    def setTagName(name)
      self.name = name
      @doc.name = name
    end

    ######## orders -> jsArray -> jsResult  ###########
    def orders
      l = []
      l << @orders << @doc.orders << @func.orders << @var.orders
      l.flatten
    end
    
  end


  # a = JsObject.new(:id__test)
  # p a.doc
  # p a.doc.byID.element
  # p a.orders
  
end

