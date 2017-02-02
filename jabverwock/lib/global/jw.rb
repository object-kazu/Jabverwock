require_relative "globalDef" 
require_relative "insertData"  
require_relative "tagManager"  
require_relative "press"

module Jabverwock
  class JW

    attr_accessor :aData, :templeteString, :pressVal
    
    def initialize
      @aData          = InsertData.new(label:"", data: "")
      @Data           = [] # insertData array
      @openString     = ""
      @closeString    = ""
      @templeteString = ""
      @memberString   = []
      @pressVal       = Press.new
      @tagManager     = TagManager.new
    end

    def prepPress
      @pressVal.templeteString = @templeteString
    end
    
    def tgStr
      assemble
      @templeteString
    end
    
#     //js
#     func importJSParameters (child:JWObject) {
#         if child.tagManager.isJsAvailable() {
#             self.tagManager.jsFileName  = child.tagManager.jsFileName
#             self.tagManager.jsType      = child.tagManager.jsType
#             self.tagManager.jsPath      = child.tagManager.jsPath
#         }
        
#     }
    
    
    def isSingleTag(isSingle)
      if KSUtil.is_bool(isSingle)
        @tagManager.isSingleTag = isSingle        
      end
    end
    
    def setID= (id)
      id = KString.checkString(id)
      @tagManager.id = id
    end
    
    def setCls= (cls)
      cls = KString.checkString(cls)
      @tagManager.cls = cls
    end
    
    def setName= (name)
      name = KString.checkString(name)
      @tagManager.name = name
    end
    
    def setLang= (lang)
      lang = KString.checkString(lang)
      @tagManager.tagAttribute.addLang = lang
    end
    
    def tagName
      @tagManager.name
    end
    
    def tagID
      @tagManager.id
    end
    
    def selectorID
      "#" + tagID
    end

    def tagCls
      @tagManager.cls
    end

    def selectorCls
      "." + tagCls
    end
    
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    def memberAssemble
      if @memberString.count > 0
        @templeteString += $RET
        ans = KString.stringArrayConectRET(@memberString)
        @templeteString += ans
      end
    end
    
    def makeTag
      @tagManager.openString
      @tagManager.closeString
    end
   
    def assemble
      makeTag
      makeResult
    end
    
    def prepTempString
      assemble
      memberAssemble
    end
    
    def press (name:, dist:)
      prepTempString
      
      if @tagManager.isJsAvailable
#         if self.tagManager.isJsAvailable() {
#             if self.tagManager.isNeedJsSrc() {
#                 // prep for js
#                 // <script>　と<その他>を分離
#                 // <その他>を別ファイルに書き出す
#                 // ＜script＞を通常通り書き出す
#                 let a = enumerateLine(target: self.templeteString)
#                 let ans = self.tagManager.extranctBetweenScriptTag(target: a)
#                 var b : [String] = []
#                 for t in ans.extract {
#                     b.append(removeHeadTAB(str: t))
#                 }
#                 self.templeteString = b.joined(separator: "\n")
                
#                 // export to js file
#                 self.pressVal.templeteString = self.templeteString
#                 self.pressVal.initResutString()               // templeteString -> resultString
#                 self.pressVal.removeAllLabel()                // remove label string
#                 let tempName = self.tagManager.jsFileName
#                 let tempDir = self.tagManager.jsPath
#                 self.pressVal.core(name: tempName, dist: tempDir)    // press resultString

#                 // prep for html and css
#                 self.templeteString = ans.scriptTag.joined(separator: "\n")
                
                
#             }else{
#                 //通常のTagと同じ処理
#             }
            
#         }

        
      end
      
      
      prepPress
      @pressVal.initResutString
      @pressVal.removeAllLabel
      @pressVal.core(name: name,  dist: dist)   
      @pressVal.resultString # 確認用の戻り値
      
    end
    
    def pressDefault
      press(name: $EXPORT_TEST_File, dist: $EXPORT_TEST_Dir)
    end
    
    
#     @discardableResult
#     func insertPress(_data_: [(label:String, data :String)]) -> String {
#         return self.pressVal.withInsert(_data_: _data_)
#     }
    
#     @discardableResult
#     func insertPress(label:String, data:String) -> String {
#         return self.pressVal.withInsert(label: label, data: data)
#     }
    
    
 
    
  end
  
# i = InsertData.new(label:"a", data: ",again")
# i.label = "b"
# p i  

end


__END__

