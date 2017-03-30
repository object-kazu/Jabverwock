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
      content = addTab @jsResult
      @scriptTag << startTag << content << endTag
      
    end
    
    def addTab(element)
      ans = ""
      element.lines{ |l|
        ans += "\t" + l
      }
      ans
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

    def isExistHeadTag
      @templeteString.include? "<head>"
    end
    def isExistScriptTag
      @templeteString.include? "<script>"
    end
    
    def reader(str) # sentence -> arr
      str.lines
    end

   def writer(arr) # arr -> sentence
     arr.inject("") do |temp, s|
       temp << s    
     end
    end

    def insertIndex (arr)
      arr.index { |i| i =~ /<\/head>/ }
    end

    def tabCount(str)
      str.count("\t")
    end

    def insertText(arr,txt)
      index = insertIndex arr
      temp = ""
      tabs = 0
      arr.each_with_index do |l,ind|
        if ind == index - 1
          tabs = tabCount l
        end
        
        if ind == index
          tabs.times{ temp << "\t"}
          temp << txt << "\n"
        end
        temp  << l
      end
      temp
    end

    def insertScriptToHead
      arr = []      
      arr = reader @templeteString
      @templeteString = insertText arr, @scriptTag
    end
    
    ### override ###
    def assembleHTML
      super
      if isExistHeadTag
        insertScriptToHead unless isExistScriptTag
      end
    end


    
    def assemble
      @templeteString = ""
      applyJS
      assembleHTML
      assembleCSS            
    end    
  end
  
   # a = JW_CSS_JS.new
   # p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
    
  
end
