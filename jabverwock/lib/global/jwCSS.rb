require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/css/css"

module Jabverwock
  using StringExtension

  class JWCSS < JW # add css functions
    
    # var style :CSS!
    # var styleArray : [CSS]  = []
    # var styleString: String = ""
    # private var nameList :[String] = [] // 重複判定に利用
    
    def initilize
      @style = CSS.new
      @nameList = [] # 重複判定に利用
    end

    def prepStyle (name)
      name = KString::checkString(name)
      s = CSS.new
      s.name = name
      @style = s
    end
    
    # func prepStyle(name: String) {
    #     style = CSS(name: name)
    # }
    # func prepStyle(property: CSS.property){
    #     style = CSS(property: property)
    # }
    
    # func styleStringInit () {
    #     styleString = "" // initilize
    # }
    
    # private func styleAssemble () {
    #     nameList = []
    #     var tempStyle : [CSS] = []
    #     if style != nil{
    #         tempStyle.append( style )
    #     }
    #     tempStyle.append(contentsOf: styleArray)
        
    #     for sty in tempStyle {
    #         /// スタイルがない（｛｝のみ）なら標示しない
    #         if sty.Str().isEmpty {
    #             continue
    #         }
            
    #         if isSameCSSName(name: sty.cssName) {
    #             continue
    #         }
    #         /// 同じ名前のスタイルは書き込まない（重複書き込み禁止）
    #         nameList.append(sty.cssName)
    #         styleString += sty.Str()
    #         styleString += RET
            
            
    #     }
        
    #     styleString = removeLastRET(str: styleString)
        
    # }
    
    
    # private func isSameCSSName (name: String) -> Bool {
    #     for n in nameList {
    #         if n == name {
    #             return true
    #         }
    #     }
        
    #     return false
    # }
    

    # func styleStr () -> String {
    #     styleStringInit()
    #     styleAssemble()
    #     return styleString
    # }

    
    # func applyStyle() {
    #     styleAssemble()
        
    #     ///検索のためにStyle tag生成
    #     let s = STYLE()
    #     s.makeTag()
    #     if templeteString.contains(s.tagManager.tempOpenString) && templeteString.contains(s.tagManager.tempCloseString) {
    #         // insert tab
    #         let tn = getTabNumber(testStr: templeteString, targetStr: STYLE_CONTENT)
    #         let tabedString = addTab(str: styleString, tabMax: tn)
            
    #         // replace text
    #         // 余分なTabを削除しておく
    #         var target = ""
    #         for _ in 0..<tn {
    #             target += TAB
    #         }
    #         target += STYLE_CONTENT
    #         templeteString = templeteString.replacingOccurrences(of: target, with: STYLE_CONTENT) // TAB + TAB + STYLE_CONTENT -> STYLE_CONTENT
    #         templeteString = templeteString.replacingOccurrences(of: STYLE_CONTENT, with: tabedString)
    #     }
    # }
    
    
    # // add member
    # func addMember(member:String)  {
    
    #     memberString.append(member)
    # }

    # func addMember (member: JWObject){
    #     // js
    #     importJSParameters(child: member)
        
    #     // html
    #     member.assemble()
    #     addMember(member: member.templeteString)
        
    #     // css
    #     if member.styleArray.count > 0{
    #         styleArray.append(contentsOf: member.styleArray)
    #     }
    #     if member.style != nil {
    #         styleArray.append(member.style)
    #     }
        
    # }
    # func addMembers (members: [JWObject]) {
    #     for m: JWObject in members {
    #         m.addMember(member: m)
    #     }
    # }
    
    # // press
    
    # override func prepTempString() {
    #     assemble()
    #     memberAssemble()
    #     applyStyle()
    # }

  end


  a = JWCSS.new
  a.prepStyle("j")
  
end
