require "global/globalDef"
require "global/jw"
require "css/css"
require "global/jw_CSS"
require "js/jsObject"


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

      @js.setTagName self.class.name.downcase

    end
    
    # alias
    def jdoc
      @js.doc
    end

    def jsRead(path)
      @js.readIn path
    end
    
    
    ####### js ###################
    
    # rec is recording
    def rec
      @js.rec
    end
    
    # order is js statement
    # orders is serial js statement
    def orders
      @js.orders
    end
    
    # override
    # see jw class
    def attrSymbol(tag)
      super tag 

      #selectors(id, cls, name) -> JsObject -> JsDocumet, ect
      @js.updateSelector tag
    end

    #override
    def jsAttrForSymboleStringData(symbol,string)
      ans = KSUtil.combineSym symbol, string
      @js.updateSelector ans
    end
    
    ####### add child ############
    
    # add js statement, member should be based on JW_CSS_JS class
    # @param [JS] member
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
    
    # js statement puts into script tags
    def applyJS      
      assembleJS
      startTag = "<script>"
      endTag = "</script>"
      content = @jsResult
      @scriptTag << startTag << "\n" << content << endTag << $RET
    end
    
    # self.js.order add to jsArray
    # because jsArray just only evaluate, js order is not evaluate to make code.
    def self_JsOrders_add_to_self_jsArray
      @jsArray.append @js.orders
    end
    
    # js collect from child and member
    def assembleJS
      @jsResult = ""
      self_JsOrders_add_to_self_jsArray
      @jsArray.each do |j|
        @jsResult << j + $RET
      end
      @jsResult.removeLastRET   
    end
    
    # just show js code
    # mainly use for checking the code.
    def showJsResult
      @jsResult
    end
    
    # check <body> tag
    def isExistBodyTagAtTempleteString
      @templeteString.include? "<body>"
    end
    
    # check <script> tag
    def isExistScriptTagAtTempleteString
      @templeteString.include? "<script>"
    end
    
    # check js result exist 
    def isExistScriptContentAtTempleteString
      return false if @jsResult.empty?
      true
    end
    
    
    def templeteStringArray
      KString.reader @templeteString
    end
    
    # count tag number befor <body> tag
    # just for alignment code
    # @example
    #   \t<body> -> return 1
    #    \t\t<body> -> return 2
    def tabNumberBodyTag
      arr = templeteStringArray
      num = 0
      arr.each do |v|
        if v.include? "<body>"
          num = KString.tabCount v
        end
      end
      num
    end
    
    # insert js script into body tag
    def insertScriptToBody     
      @templeteString = KString.insertText templeteStringArray, @scriptTag
    end
    
    # ## override ###
    def assembleHTML
      super

      return unless isExistBodyTagAtTempleteString
      return if     isExistScriptTagAtTempleteString
      return unless isExistScriptContentAtTempleteString

      insertScriptToBody
      
    end

    # ## override ###
    def assemble
      applyJS
      assembleHTML
      assembleCSS            
    end    
  end  
  
end


