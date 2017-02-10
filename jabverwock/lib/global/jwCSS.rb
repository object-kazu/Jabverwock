require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/css/css"

module Jabverwock
  using StringExtension

  class JWCSS < JW # add css functions

    attr_accessor :style, :styleArray
        
    def initialize
      super
      @name = self.name
      
      @style = CSS.new("#{name}")
      @styleArray = []
      @styleString  = ""
      
      @nameList = [] # 重複判定に利用
    end
    
    def name
      self.class.to_s.split("::").last.downcase
    end

    
    def styleWithName (name)
      name = KString::checkString(name)
      @style.name = name
    end

    def styleWithProperty(property)
      if property.is_a?(Property)
        @style.property = property
      end
    end
    
    def styleStringInit
      @styleString = ""
    end
    
    # add member
    
    # def addMember (member)
    #   member = KString::checkString(member)
    #   @memberString += member
    # end

    def addJWCSSAsMember (member)
      if member.is_a?(JWCSS)
        # js
#     importJSParameters(child: member)
        
        # html

        #addMember(member.templeteString)
        
        # css
        if member.styleArray.count > 0
          @styleArray << member.styleArray
        end

        if member.style != nil
          @styleArray << member.style
        end
        
      end
    end
        
    def addMemberObjects (members)
      members.each do |obj| 
        addMember obj
      end
    end
    
    
    # // press
    def prepTempString #override
      assemble
      memberAssemble
      applyStyle
    end
    
    def styleStr
      styleStringInit
      styleAssemble
      return styleString
    end
    
    def applyStyle
      styleAssemble
    #     ///検索のためにStyle tag生成
      s = Style.new
      s.makeTag
      if @templeteString.include?(s.tagManager.tempOpenString) 
      end
      
    end

    def isIncludeAtTempleteString(targetOpenString, targetCloseString)
      
    end
    
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

    
    
    private
    
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
    

    
    

  end

  class Style < JW
    
    def initialize
      super
      setName = "style"
      addCihld("style test")
    end
  end
  
  # a = JWCSS.new
  # a.style.name = "pp"
  # a.style.property.color = "red"
  # p a

  
end
