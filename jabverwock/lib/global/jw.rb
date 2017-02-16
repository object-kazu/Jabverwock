require_relative "globalDef" 
require_relative "tagManager"  
require_relative "press"

module Jabverwock
  using StringExtension
  class JW

    attr_accessor :name, :aData, :templeteString, :pressVal, :tagManager
    
    def initialize
      @name           = self.name
      @aData          = "".varIs("")
      @Data           = [] # insertData array
      @openString     = ""
      @closeString    = ""
      @templeteString = ""
      @memberStringArray   = []
      @pressVal       = Press.new ## input -> templeteString, output -> resultString
      @tagManager     = TagManager.new
    end

    def attr(tag, val)
      @tagManager.tagAttr(tag,val)
      self
    end

    # ex) @tagManager.Id = id
    # mainAttr.each do |attr| 
    #   define_method "#{attr}=" do |val|
    #     val = KString.checkString val
    #     eval "@tagManager.#{attr} = val"
    #   end
    # end
    
    mainAttr =  [:id, :cls, :name]
    # ex) return @tagManager.Id
    mainAttr.each do |attr|      
      define_method "tag#{attr.capitalize}" do
        eval "@tagManager.#{attr}"
      end
    end
    
    
    def name
      self.class.to_s.split("::").last.downcase
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
    
    
    def setLang= (lang)
      lang = KString.checkString(lang)
      @tagManager.tagAttribute.addLang = lang
    end

    
    
    def selectorID
      "#" + @tagManager.tagAttribute.id
    end


    def selectorCls
      "." + @tagManager.tagAttribute.cls
    end
    
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    def memberAssemble
      if @memberStringArray.count > 0
         @templeteString += $RET
         ans = KString.stringArrayConectRET(@memberStringArray)
         @templeteString += ans
      end
    end
    
    def makeTag
      @tagManager.openString
      @tagManager.closeString
    end
   
    def assemble    
      if @tagManager.name == ""
        @tagManager.name = @name        
      end      
      makeTag
      makeResult
      memberAssemble
    end
        
    def press (name:, dist:)
      assemble
      
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
    
    
    def pressAInsert(insertData)
      KSUtil.labelDataPair?(insertData)
      @pressVal.withInsert(insertData)
      @pressVal.resultString # 確認用の戻り値
    end
    
    def pressInsertEach(*insertData)
      @pressVal.withInsertEach(insertData)
      @pressVal.resultString # 確認用の戻り値      
    end
    

  end
  
end


