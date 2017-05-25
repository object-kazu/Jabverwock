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
  using ArrayExtension
  using SymbolExtension
  
  # this class is css function add to jw class
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
    def usageCSS
    <<-MEMO_css
        - id, clsが設定されている場合
          name + {id,cls} + {css}
          p #id {color:red;}
          p .cls {color:red;}

        - id, clsが設定されていない場合
          p {color:red;}

        - id, clsのみを設定したい場合
          a = CSS.new(".sample") // cls
          a = CSS.new("#sample") // id
          addCss a 
        
    MEMO_css
      
    end
        
    def cssWithName (name)
      @css.name = name.to_s
    end
    
    def cssStringInit
      @cssString = ""
    end

    def addCss (*css)
      css.each do |c|
        if c.name == ""
          c.name = @css.name
        end        
      end
      @cssArray += css      
    end
    
    def applyCss
      cssStringInit
      atcs = showCssString
           
      unless atcs == ""
        tgCss = KSUtil.intoStyleTag atcs
        addAssembleStyle tgCss
      end
      
    end

        
    def addAssembleStyle(str)
      # koko now
      # head tagがないとなにもない仕様にしてある
      # 外部ファイルに書き出す機能を追加するか？
      @pressVal.applyStyle str
      
    end

    def cssAssembleInit(css, cssArray)      
      css.updateCssName activeID, activeCls
      KString.makeElementArray(css, cssArray)
    end

    def activeID
      ids = ""      
      if isExistID
        ids = "#{selectorID}"        
      end
      ids
    end
    
    def activeCls
      cls = ""
      if isExistCls
        cls = "#{selectorCls}"
      end
      cls
    end
    
    
    def cssAssembleCore(css)
      @nameList << css.name        
      @cssString << css.str << $RET
      css.useFlagsInit
    end
    
    def cssAssembleLoop(arr)
      
      arr.each do |cs|

        #  スタイルがない（｛｝のみ）なら標示しない        
        next unless KString.isExistCssString cs.str
        
        # 同じ名前のスタイルは書き込まない（重複書き込み禁止）
        next if isSameCSSName(cs.name)

        cssAssembleCore cs
      end      
    end
    
    # change to function as cssAssemble need arguments
    # ex) cssAssemble(@css, @cssArray)

    #   - cssのみはid,clsの処理を追加
    #   - cssArrayの中身は処理しない
    #   -＞ cssArrayに追加するときに処理するため
    
    def cssAssemble(css, cssArray)      
      @nameList = []      
      newArr = cssAssembleInit css, cssArray
      cssAssembleLoop newArr
      @cssString.removeLastRET
    end

    

    def isSameCSSName(name)
      @nameList.include? name
     end
    
    
    def showCssString
      cssStringInit
      cssAssemble @css, @cssArray
    end

    def updateCssName
      @css.updateCssName activeID, activeCls
    end
    
    ####### add member ############
    
    def addMemberString (memberString)
      KString.isString? memberString
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
   
      unless member.cssArray.empty?
        @cssArray.append member.cssArray
      end
      
      member.updateCssName
      @cssArray.append member.css
    end
    
    def addHTML(member)
      member.assembleHTML
      addMemberString member.templeteString
    end
    
    def addJS( member )
      # implement at class JW_CSS_JS
      member # just write for reek warnig
    end
    
    
    def addMembers (*members)
      members.each do |obj| 
        self.addMember obj
      end
    end

    
    
    #########  press ###########
    ### override ###
    def assembleHTML
      if @tagManager.name.empty?
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
