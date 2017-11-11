require "global/globalDef"
require "global/jw"
require "global/jw_CSS"
require "global/jw_CSS_JS"
require "js/jsObject"
require "opal/opalFileReader"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #JW_CSS_OPAL_JS class add function of Javascript, mainly DOM functions
  class JW_CSS_OPAL_JS < JW_CSS_JS # add css functions
    attr_accessor :jsArray, :opalPath
    attr_reader :opalFileName
    
    def initialize
      super
      @opalPath = ""
      @opalFileName = ""
    end
    
    ####### opal ###################
    
    def readOpalFile(path)
      @opalPath = path
      op = OpalFileReader.new
      op.opalPath = path
      op.readOpal
      @opalFileName = op.opalFileName
    end
    
    def isExistOpalScript
      @opalPath == "" ? false : true
    end
    
    def insertOpalScript
      return unless isExistOpalScript
      addOpalScriptTag
    end
    
    def addOpalScriptTag
      # <script src="hellow.js"></script>
      
      startTag = "<script src=#{@opalFileName}.js>"
      endTag = "</script>"
      @scriptTag << startTag << endTag << $RET
      
    end
        
  end  
end


