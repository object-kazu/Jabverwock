require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require "../../lib/css/css"

module Jabverwock
  using StringExtension

  class JWCSS < JW # add css functions

    attr_accessor :css, :cssArray, :cssString
        
    def initialize
      super      
      @css = CSS.new("#{name}")
      @cssArray = []
      @cssString  = ""      
      @nameList = [] # 重複判定に利用
      
    end
    
    ########## CSS #############
    
    def cssWithName (name)
      name = KString::checkString(name)
      @css.name = name
    end
    
    def cssStringInit
      @cssString = ""
    end
    
    # applyCss(@css, @cssArray)
    def applyCss(css, cssArray)
      cssAssemble(css, cssArray)
      # 検索のためにStyle tag生成
      j = JWCSS.new
      j.makeTag
      if @templeteString.include?(j.tagManager.tempOpenString) &&
         @templeteString.include?(j.tagManager.tempCloseString)
        
        # insert tab
        tn = KString.getTabNumber @templeteString
        tabedString = KString.addTab(str: @templeteString, num: tn)
                
        #replace text
        #余分なTabをDelete
        target = ""
        tn.times do
          target += $TAB
        end
        target += $STYLE_CONTENT

        # TAB + TAB + STYLE_CONTENT -> STYLE_CONTENT
        @templeteString.gsub!(/#{target}/, $STYLE_CONTENT)
        @templeteString.gsub!(/#{$STYLE_CONTENT}/, tabedString)
        
      end
      
    end
    
    # change to function as cssAssemble need arguments
    # ex) cssAssemble(@css, @cssArray)
    def cssAssemble(css, cssArray)
      @nameList = []
      tCssArray = makeCssArray(css, cssArray)

      
      tCssArray.each do |cs|
        
        #  スタイルがない（｛｝のみ）なら標示しない
        next unless isExistCssString cs.str
        
        # 同じ名前のスタイルは書き込まない（重複書き込み禁止）
        next if isSameCSSName(cs.name)

        @nameList << cs.name        
        @cssString << cs.str << $RET
      end
      
       @cssString.removeLastRET
    end
    
    def isExistCssString(str)
      
      if str == nil
        return false
      end

      if !str.include?("{") || !str.include?("}")
        return false
      end
      
      removeFront = str.gsub(/.*{/, "") 
      removeBack = removeFront.gsub(/}/, "")
      removeRET = removeBack.gsub(/\n/, "")
      
      if removeRET.nil? || removeRET == ""
        return false
      end

      return true
    end
    
    
    def makeCssArray (css, cssArray)
      temCssArray = []
      
      if css != nil
        temCssArray << css
      end
      
      if cssArray.count > 0
        temCssArray += cssArray
      end      
      return temCssArray
    end
    
    def isSameCSSName(name)
      @nameList.each do |n |
        if n == name
          return true
        end
      end
      return false
    end

    def showCssString
      cssStringInit
      cssAssemble(@css, @cssArray)
    end
    
    
    ####### add child ############
    def addMemberString (memberString)
      memberString = KString::checkString(memberString)
      @memberString += memberString
    end

    def addMember (member) 
      if member.is_a?(JWCSS)
        addJS member
        addHTML member
        addCSS member
      end
    end

    def addCSS(member)
      if member.cssArray.count > 0
        @cssArray += member.cssArray
      end

      if member.css != nil
        
        @cssArray << member.css
        
      end
    end
    
    def addHTML(member)
      #addMember(member.templeteString)
    end
    
    def addJS(member)
      # importJSParameters(child: member)
    end
    
    
    def addMembers (*members)
      members.each do |obj| 
        self.addMember obj
      end
    end
    
    
    #########  press ###########
    ### override ###
    def assemble
        if @tagManager.name == ""
        @tagManager.name = @name        
      end
      makeTag
      makeResult
      memberAssemble
      applyCss(@css, @cssArray)
   
    end
  end

  
  # a = JWCSS.new
  # # p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
  

  
end
