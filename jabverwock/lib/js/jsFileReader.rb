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
  
  # this class is treat js file import to between script tags
  class JsFileReader < JsBase
           
    attr_accessor :jsArr
    
    def initialize(*inits)
      super inits

      @jsArr = []
    end

    def fileReading(txt)
      KSUtil.fileReadingToArr txt, @jsArr
    end
    
    
    
    
  end


  # a = JsObject.new(:id__test)
  # p a.doc
  # p a.doc.byID.element
  # p a.orders
  
end

