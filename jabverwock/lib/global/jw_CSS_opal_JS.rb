# require "global/globalDef"
# require "global/jw"
# require "global/jw_CSS"
# require "global/jw_CSS_JS"
# require "js/jsObject"
# require "opal/opalFileReader"
# require "css/css"

# module Jabverwock
#   using StringExtension
#   using ArrayExtension
#   using SymbolExtension
  
#   #JW_CSS_OPAL_JS class add function of Javascript, mainly DOM functions
#   class JW_CSS_OPAL_JS < JW_CSS # add css functions
#     attr_accessor :jsArray, :opalPath
#     attr_reader :opalFileName
    
#     def initialize
#       super
#       @js = JsObject.new
#       @opalPath = ""
#       @opalFileName = ""
#       @jsResult = ""
#       @jsArray = []
#       @scriptTag = ""

#       @js.setTagName self.class.name.downcase

#     end
    
#     ### alias ############
#     def jdoc
#       @js.doc
#     end

#     def jsRead(path)
#       @js.readIn path
#     end

    
#     ####### opal ###################
    
#     def readOpalFile(path)
#       @opalPath = path
#       op = OpalFileReader.new
#       op.opalPath = path
#       op.readOpal
#       @opalFileName = op.opalFileName
#     end
    
#     ####### js ###################
    
#     def rec
#       @js.rec
#     end

#     def orders
#       @js.orders
#     end
    
#     def attrSymbol(tag)
#       super tag # see jw class

#       #selectors(id, cls, name) -> JsObject -> JsDocumet, ect
#       @js.updateSelector tag
#     end

#     #override
#     def jsAttrForSymboleStringData(symbol,string)
#       ans = KSUtil.combineSym symbol, string
#       @js.updateSelector ans
#     end
    
#     ####### add child ############
#     ## override
#     def addJS(member)
#       unless member.is_a?(JW_CSS_JS)
#         assert_raise{
#           p "member class is #{member.class}"
#           p "error, member should be JW_CSS_JS"
#         }
#       end

#       @jsArray.append member.orders

#       if member.jsArray.count > 0
#         @jsArray.append member.jsArray
#       end

      
#     end

#     def applyJS      
#       assembleJS
#       startTag = "<script>"
#       endTag = "</script>"
#       content = @jsResult
#       @scriptTag << startTag << "\n" << content << endTag << $RET
#     end
        
#     def self_JsOrders_add_to_self_jsArray
#       @jsArray.append @js.orders
#     end
    
#     def assembleJS
#       # js collect from child and member
#       @jsResult = ""
#       self_JsOrders_add_to_self_jsArray
#       @jsArray.each do |j|
#         @jsResult << j + $RET
#       end
#       @jsResult.removeLastRET   
#     end

#     def showJsResult
#       @jsResult
#     end

#     def isExistBodyTagAtTempleteString
#       @templeteString.include? "<body>"
#     end
    
#     def isExistScriptTagAtTempleteString
#       @templeteString.include? "<script>"
#     end
    
#     def isExistScriptContentAtTempleteString
#       return false if @jsResult.empty?
#       true
#     end
    
#     def templeteStringArray
#       KString.reader @templeteString
#     end
    
    
#     def tabNumberBodyTag
#       arr = templeteStringArray
#       num = 0
#       arr.each do |v|
#         if v.include? "<body>"
#           num = KString.tabCount v
#         end
#       end
#       num
#     end

#     def insertScriptToBody     
#       @templeteString = KString.insertText templeteStringArray, @scriptTag
#     end

    
#     def isExistOpalScript
#       @opalPath == "" ? false : true
#     end
    
#     def insertOpalScript
#       return unless isExistOpalScript
#       addOpalScriptTag
#     end
    
#     def addOpalScriptTag
#       # <script src="hellow.js"></script>
      
#       startTag = "<script src=#{@opalFileName}.js>"
#       endTag = "</script>"
#       @scriptTag << startTag << endTag << $RET
      
#     end
    
#     ### override ###
#     def assembleHTML
#       super

#       return unless isExistBodyTagAtTempleteString
#       return if     isExistScriptTagAtTempleteString
#       return unless isExistScriptContentAtTempleteString

#       insertScriptToBody
#       insertOpalScript
      
#     end

    
#     def assemble
#       @templeteString = ""
#       applyJS
#       assembleHTML
#       assembleCSS            
#     end    
#   end
  
#    # a = JW_CSS_OPAL_JS.new
#    # p a
#   # # a.css.name = "pp"
#   # # a.css.color = "red"
#   # #a.name = "test"
#   # p a.pressDefault
    
  
# end


