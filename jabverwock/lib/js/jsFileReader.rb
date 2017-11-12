require "global/globalDef"
require "js/jsDocument"
require "js/jsBase"
require "js/jsFunction"
require "js/jsVar"
require "pathname"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is treat js file import to between script tags
  class JsFileReader < JsBase
           
    attr_reader :jsArr
    
    def initialize(*inits)
      super inits

      initJsArr
    end

    def initJsArr
      @jsArr = []
    end
    
    def read(txt) # file at current dir 
      initJsArr
      KSUtil.fileReadingToArr txt, @jsArr
    end

    def readIn(path)
      initJsArr
      r = Pathname(path).expand_path.read(:encoding => Encoding::UTF_8)
      @jsArr = r.split("\n")
    end
        
    
  end  
end

