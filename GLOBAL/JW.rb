require_relative "globalDef" 
require_relative "insertData"  
require_relative "tagManager"  
require_relative "press"

module Jabverwock
  class JW

    attr_accessor :aData
    
    def initialize
      @aData = InsertData.new(label:"", data: "")
      @Data = [] # insertData array
      @openString     = ""
      @closeString    = ""
      @templeteString = ""
      @memberString   = []
      @pressTreatment = Press.new
      @tagManager = TagManager.new
    end

    def to_s
      "#{@aData}, #{@openString}, #{@closeString}, #{@templeteString}, #{@memberString}" 
    end

    def tgStr
      assemble
      @tempOpenString
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
    
    # def setID(id)
    #   id = KString.checkString(id)
    #   @tagManager.id = id
    # end
    
#     func setID(id:String) {
#         tagManager.id = id
#     }
    
#     func setCls(cls:String) {
#         tagManager.cls = cls
#     }
#     func setName(name:String) {
#         tagManager.name = name
#     }
#     func setLang(lang:LANG) {
#         tagManager.attr.add(lang: lang)
#     }
#     func tagName() -> String {
#         return tagManager.name
#     }
#     func tagID() -> String {
#         if tagManager.id.isEmpty {
#             assertionFailure("set id")
#         }
#         return tatManager.id
#     }
#     func selectorID () -> String {
#         return "#" + tagID()
#     }
    
#     func tagCls() -> String {
#         if tagManager.cls.isEmpty {
#             assertionFailure("set cls")
#         }
#         return tagManager.cls
#     }

#     func selectorCls () -> String {
#         return "." + tagCls()
#     }
    
    def makeTag
      @tagManager.openString
      @TagManager.closeString
    end
    
    
    def prepTempString
      assemble
      memberAssemble
    end

    def assemble
      makeTag
      makeResult
    end
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    def memberAssemble
      if memberString.count > 0
        @templeteString += $RET
        ans = KString.stringArrayConectRET(memberString)
        @templeteString += ans
      end
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
#                 self.pressTreatment.templeteString = self.templeteString
#                 self.pressTreatment.initResutString()               // templeteString -> resultString
#                 self.pressTreatment.removeAllLabel()                // remove label string
#                 let tempName = self.tagManager.jsFileName
#                 let tempDir = self.tagManager.jsPath
#                 self.pressTreatment.core(name: tempName, dist: tempDir)    // press resultString

#                 // prep for html and css
#                 self.templeteString = ans.scriptTag.joined(separator: "\n")
                
                
#             }else{
#                 //通常のTagと同じ処理
#             }
            
#         }

        
      end
      @pressTreatment.templeteString = @templeteString
      @pressTreatment.initResutString
      @pressTreatment.removeAllLabel
      @pressTreatment.core(name: name,  dist: dist)
      @pressTreatment.resultString # 確認用の戻り値
      
    end
    
    def pressDefault
      press(name: $EXPORT_TEST_File, dis: $EXPORT_TEST_Dir)
    end
    
    
#     @discardableResult
#     func insertPress(_data_: [(label:String, data :String)]) -> String {
#         return self.pressTreatment.withInsert(_data_: _data_)
#     }
    
#     @discardableResult
#     func insertPress(label:String, data:String) -> String {
#         return self.pressTreatment.withInsert(label: label, data: data)
#     }
    
    
 
    
  end
  
# i = InsertData.new(label:"a", data: ",again")
# i.label = "b"
# p i  

end


__END__


