if $FOR_GEM
  require "global/globalDef"
  require "global/jw"
  require "css/css"
  require "global/jw_CSS"
  require "js/jsObject"
  
else
  # test
  require '../../lib/global/globalDef'  
  require '../../lib/global/jw'
  require '../../lib/css/css'  
  require '../../lib/global/jw_CSS'  
  require '../../lib/js/jsObject'  
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #JW_CSS_JS class add function of Javascript, mainly DOM functions
  class JW_CSS_JS < JW_CSS # add css functions
    attr_accessor :js, :jsArray
    
    def initialize
      super
      @js = JsObject.new
      @jsResult = ""
      @jsArray = []
      @scriptTag = ""
    end
     
    ####### js ###################
    def rec
      @js.rec
    end

    def orders
      @js.orders
    end
    
    def attrSymbol(tag)
      super tag # see jw class

      #selectors(id, cls, name) -> JsObject -> JsDocumet, ect
      @js.updateSelector tag
    end
    
    ####### add child ############
    ## override
    def addJS(member)
      unless member.is_a?(JW_CSS_JS)
        assert_raise{
          p "member class is #{member.class}"
          p "error, member should be JW_CSS_JS"
        }
      end
      @jsArray.append member.orders
      
      if member.jsArray.count > 0
        @jsArray.append member.jsArray
      end
    end

    def applyJS
      assembleJS
      startTag = "<script>"
      endTag = "</script>"
      content = @jsResult
      @scriptTag << startTag << "\n" << content << endTag << $RET
    end
        
    def self_JsOrders_add_to_self_jsArray
      @jsArray.append @js.orders
    end
    
    def assembleJS
      # js collect from child and member
      @jsResult = ""
      self_JsOrders_add_to_self_jsArray
      @jsArray.each do |j|
        @jsResult << j + $RET
      end
      @jsResult.removeLastRET   
    end

    def showJsResult
      @jsResult
    end

    def isExistHeadTagAtTempleteString
      @templeteString.include? "<head>"
    end
    def isExistScriptTagAtTempleteString
      @templeteString.include? "<script>"
    end
    
    def isExistScriptContentAtTempleteString
      return false if @jsResult.empty?
      true
    end
    
    def templeteStringArray
      KString.reader @templeteString
    end
    
    def tabNumberHeaderTag
      arr = templeteStringArray
      num = 0
      arr.each do |v|
        if v.include? "<head>"
          num = KString.tabCount v
        end
      end
      num
    end

    def insertScriptToHead     
      @templeteString = KString.insertText templeteStringArray, @scriptTag
    end
    
    ### override ###
    def assembleHTML
      super      
      return unless isExistHeadTagAtTempleteString
      return unless isExistScriptTagAtTempleteString
      return unless isExistScriptContentAtTempleteString
      insertScriptToHead
      
    end


    
    def assemble
      @templeteString = ""
      applyJS
      assembleHTML
      assembleCSS            
    end    
  end
  
  #  a = JW_CSS_JS.new
  #  p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
    
  
end


