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

    # module KS.callMyに移行
    #  func callClassName() -> String {

    # module KS.removeLastRETに移行
    #     func removeLastRET (str: String) -> String {

    # module KS.removeLastTABに移行    
    #     func removeLastTAB (str: String) -> String {

    # module KS.removeHeadTABに移行        
    #     func removeHeadTAB (str:String) -> String{

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
      if KS.is_bool(isSingle)
        @tagManager.isSingleTag = isSingle        
      end
    end
    
    
    
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
#         return tagManager.id
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
    
#     func makeTag() {
#         tagManager.openString(spec: "")
#         tagManager.closeString(spec: "")
#     }
    
#     // tab揃え
#     func tabNumber (str: String) -> Int {
#         let last = removeLastTAB(str: str) //余分なTabを除く
#         let a = last.components(separatedBy: "\t")
#         return a.count - 1
#     }
    
    
    
#     func addTab (str: String, tabMax : Int) -> String {
#         var ans = ""
#         let l = str.lines
#         for e:String in l {
#             let tn = tabNumber(str: e)
#             let a = tabMax - tn
#             let s = addheadTab(str: e, num: a)
#             ans += s
#             ans += "\n"
#         }
        
#         return ans
#     }
    
#     func addheadTab (str: String, num:Int) -> String {
#         var t = ""
#         for _ in 0..<num {
#             t += "\t"
#         }
#         t += str
#         return t
#     }
    
#     func getTabNumber (testStr:String, targetStr: String ) -> Int {
#         let lin = testStr.lines
#         for l in lin {
#             if l.contains(targetStr) {
#                 return tabNumber(str: l)
#             }
#         }
#         return 0
#     }
    
#     func getTabMax (testStr:String) -> Int {
#         var max = 0
#         let lin = testStr.lines
#         for l in lin {
#             let n = tabNumber(str: l)
#             if n > max {
#                 max = n
#             }
#         }
#         return max
        
#     }

    
#     func prepTempString()  {
#         assemble()
#         memberAssemble()
#     }
    
#     func assemble(){
#         makeTag()
#         makeResult()
#     }
    
#     func makeResult(){
#         templeteString += tagManager.tempOpenString + RET
        
#         if !tagManager.tempCloseString.isEmpty {
#             templeteString += tagManager.tempCloseString
#         }
        
#         // 最後のRETを取り除く
#         templeteString = removeLastRET(str: templeteString)
#     }
    
#     func memberAssemble () {
        
#         if memberString.count > 0 {
#             templeteString += RET
            
#             var m: String = ""
#             for t: String in memberString {
#                 m += t
#                 m += RET
#             }
            
#             templeteString += m
#         }
#     }
    
#     // resultStringをファイルに書き出す
#     @discardableResult
#     func press(name: String, dist : String) -> String{
#         self.pressTreatment = Press()   // prep templeteString
#         prepTempString()                // make templeteString
        
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
        
#         self.pressTreatment.templeteString = self.templeteString
#         self.pressTreatment.initResutString()               // templeteString -> resultString
#         self.pressTreatment.removeAllLabel()                // remove label string
#         self.pressTreatment.core(name: name, dist: dist)    // press resultString
        

#         return self.pressTreatment.resultString
#     }
    
#     @discardableResult
#     func press () -> String {
#         return self.press(name: EXPORT_TEST_File, dist: EXPORT_TEST_Dir)
#     }
    
#     @discardableResult
#     func insertPress(_data_: [(label:String, data :String)]) -> String {
#         return self.pressTreatment.withInsert(_data_: _data_)
#     }
    
#     @discardableResult
#     func insertPress(label:String, data:String) -> String {
#         return self.pressTreatment.withInsert(label: label, data: data)
#     }
    
    
    def assemble
      makeTag
      makeResult
    end

    def makeTag
      
    end

    def makeResult
      
    end

    
  end
  
# i = InsertData.new(label:"a", data: ",again")
# i.label = "b"
# p i  

end


__END__


