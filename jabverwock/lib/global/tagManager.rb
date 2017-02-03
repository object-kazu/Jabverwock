require_relative "globalDef" 
require_relative "tagAttribute" 

module Jabverwock
  using StringExtension
  class TagManager
    attr_accessor :name, :id, :cls, :tagAttribute, :isSingleTag, :closeStringNotRequire, :tempOpenString, :tempCloseString
    attr_accessor :jsPath, :jsType, :jsPathPlusName, :jsFileName    
    
    def initialize
      @tempOpenString = String.new
      @tempCloseString = String.new
      
      @name = String.new
      @id   = String.new
      @cls  = String.new
      
      @tagAttribute = TagAttribute.new
      @attributeString = String.new

      @isSingleTag = false

      #js
      @jsPath         = ""
      @jsType         = ""
      @jsFileName     = ""
      @jsPathPlusName = ""
      
      #img, meta tag
      @closeStringNotRequire = false
    end

    ####### add attribute #############################
    def addID
      if !@id.empty?
        @id = KString.checkString(@id)
        st = "id=" + "\"" + @id + "\""
        @id = KString.addSpace(st)
      end
    end

    def addCls
      if !@cls.empty?
        @cls = KString.checkString(@cls)
        st = "class=" + "\"" + @cls + "\""
        @cls = KString.addSpace(st)
      end
    end

    def addAttribute
      if !@tagAttribute.aString.empty?
        @attributeString = KString.checkString(@attributeString)
        @attributeString = KString.addSpace(@tagAttribute.aString)
      end
    end


    #####  js           ###########################
        
#     private func addPath() {
        
#         if jsFileName.isEmpty {return}
#         if jsPath.isEmpty {
#             jsPath = EXPORT_TEST_JS_Dir
#         }
        
#         jsPathPlusName = SPC + "src=" + DOUBLE_QUO + jsPath + jsFileName + DOUBLE_QUO
#     }
    
#     private func addType()  {
#         if jsType.isEmpty{return}
#         jsType = SPC + "type=" + DOUBLE_QUO + jsType + DOUBLE_QUO
#     }
#     /// js <script></script>に挟まれた文字列を取り出す
#     func extranctBetweenScriptTag (target: [String]) -> (scriptTag:[String], extract:[String]) {
#         /*
#          [0] = "<!DOCTYPE html type=\"text/javascript\" src=\"/Users/shimizukazuyuki/Desktop/index/test.js\">"
#          [1] = "<script type=\"text/javascript\" src=\"/Users/shimizukazuyuki/Desktop/index/test.js\">"
#          [2] = "\ttest\t"
#          [3] = "</script>"
         
#          */
        
#         var s : [String] = []
#         var e : [String] = []
        
#         var start = false
#         for st in target {
#             if st.contains("<script") {
#                 s.append(st)
#                 start = true
#                 continue
#             }
            
#             if st.contains("</script>") {
#                 s.append(st)
#                 start = false
#                 continue
#             }
            
#             if start {
#                 e.append(st)
                
#             }else{
#                 s.append(st)
#             }
            
            
#         }
#         return (scriptTag: s, extract: e)
#     }

    
#     /*
#      => isNeedJsSrc
#      <script type="text/javascript" src="/Users/shimizukazuyuki/Desktop/index/test.js"></script>
     
#      => InDocument
#      <script type="text/javascript"></script>
     
     
#      */
    
    def isJsAvailable
      if !jsType.empty? || !jsPath.empty? || !jsFileName.empty? # <script> available
        return true
      end
      return false
    end
    
#     func isNeedJsSrc () -> Bool {
#         if isJsAvailable() {
#             if !jsFileName.isEmpty {
#                 return true
#             }
#         }
#         return false
#     }
    
    
#     private func scriptTag () -> String {
#         tempOpenString = "<" + name + id + cls + attr.aString + jsType + jsPathPlusName + ">"
#         return tempOpenString
#     }

    
    #####  tag judgemnet ###########################
    def isBrTag
      @name == "br" ? true : false
    end

       
    def isScriptTag
      @name == "script" ? true : false
    end

    ##### open and close string ###################
   
    def closeStringReplace(of:, with:)
      @tempCloseString = KString.reprace(str: @tempCloseString, of: of, with: with)
    end
    
    def  openStringReplace(of:, with:)
      @tempOpenString = KString.reprace(str: @tempOpenString, of: of, with: with)
    end
    
    def openString
      if @name == ""
        return ""
      end
      
      if isBrTag()
        return ""
      end
      
      #  id, clsなどの指定が必要Tagはここより下に記入
        
#         addID()
#         addCls()
#         addPath()
#         addType()
        
#         // script
#         if isScriptTag() {
#             return scriptTag()
#         }
      
      addID
      addCls

      # tag attribute treatment
      addAttribute
      
      @tempOpenString = "<" + @name + @id + @cls + @attributeString + ">"
      end
    
    def closeString
      if name == ""
        return ""
      end
      if isBrTag
        return @tempCloseString = "<" + @name  + ">"
      end

      # closeStringNotRequire => bool値に変更する      
        # // not require
        # /// meta, img
        # if spec == NOT_REQUIRE {
        #     return ""
        # }
      if closeStringNotRequire
        return "" # no close string
      end

      if isSingleTag
        return @tempCloseString = ""
      end
        
      @tempCloseString = "</" + @name  + ">"
    end
    
  end
end
__END__
