if $FOR_GEM
  require "global/globalDef"
  require "global/jw"
  require "css/css"
  
else
  # test
  require '../../lib/global/globalDef'  
  require '../../lib/global/jw'  
  require '../../lib/css/css'  
  
end


module Jabverwock
  using StringExtension

  class JW_CSS < JW # add css functions

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

    def addCss (*css) #change arg, that is array
      css.each do |c|
        if c.name == ""
          c.name = @css.name
        end        
      end
      @cssArray += css      
    end
    
    def applyCss
      cssStringInit
      tcs = tabedCss

      unless tcs == ""
        convertStyleTag tcs
      end
      
    end

    def tabedCss
      ans = cssAssemble(@css, @cssArray)
      KString.addTabEachLine ans      
    end
    
    def convertStyleTag(str)
      tabbedEachLine = KString.addTabEachLine str
      styStart   = "<style>\n"
      styContent = "#{tabbedEachLine}\n"
      styEnd     = "\t</style>\n"
        
      styTag = styStart << styContent << styEnd
      tabbedStyTag = KString.addTabEachLine styTag

      # koko now
      # head tagがないとなにもない仕様にしてある
      # 外部ファイルに書き出す機能を追加するか？
      @pressVal.applyStyle tabbedStyTag  
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
    
    
    ####### add member ############
    
    def addMemberString (memberString)
      memberString = KString::checkString(memberString)
      @memberStringArray << memberString
    end

    def addMember (member)
      if member.is_a? JW 
        addJS(member)
        addHTML(member)
        addCSSmember(member)
      end
    end

    def addCSSmember(member)      
      if member.cssArray.count > 0
        @cssArray += member.cssArray
      end
      
      @cssArray << member.css
      # if member.css != nil
      #   @cssArray << member.css
      # end

    end
    
    def addHTML(member)
      member.assembleHTML
      addMemberString(member.templeteString)
    end
    
    def addJS(member)
      # implement at class JW_CSS_JS
    end
    
    
    def addMembers (*members)
      members.each do |obj| 
        self.addMember obj
      end
    end

    
    
    #########  press ###########
    ### override ###
    def assembleHTML
      if @tagManager.name == ""
        @tagManager.name = @name        
      end
      makeTag
      makeResult
      memberAssemble
    end
    
    def assembleCSS
      @pressVal.templeteString = @templeteString
      applyCss
    end
    
    def assemble
      assembleHTML
      assembleCSS
   
    end
  end

  
  #  a = JW_CSS.new
  #  p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
    
  
end
