require "global/globalDef"
require "global/jw"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is css function add to jw class
  class JW_CSS < JW # add css functions

    attr_accessor :css, :cssArray, :cssString
        
    def initialize(style="")
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
    
    # default name is class name
    # @param [String] name css name
    def cssWithName (name)
      @css.name = name.to_s
    end
    
    # initialize css
    def cssStringInit
      @cssString = ""
    end
    
    # add css
    # @param [Array<CSS>] css
    def addCss (*css)
      css.each do |c|
        if c.name == ""
          c.name = @css.name
        end        
      end
      @cssArray += css      
    end
    
    # css build = make strings
    def applyCss
      cssStringInit
      atcs = showCssString
           
      unless atcs == ""
        tgCss = KSUtil.intoStyleTag atcs
        addAssembleStyle tgCss
      end
      
    end

    # add css style
    # @note head tagがないとなにもない仕様にしてある
    # @note 外部ファイルに書き出す機能を追加するか？
    # @param [String] str
    def addAssembleStyle(str)
      @pressVal.applyStyle str
    end
    
    # combind css to cssArray
    # @param [CSS] css
    # @param [Array<CSS>] cssArray
    def cssAssembleInit(css, cssArray)      
      KString.makeElementArray(css, cssArray)
    end
    
    # css assemble main func
    # @param [CSS] css
    # @return [String] cssString
    def cssAssembleCore(css)
      @nameList << css.name        
      @cssString << css.str << $RET
    end

    
    # call cssAssembleCore for cssArray
    # @param [Array] arr css array
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
    # @param [CSS] css
    # @param [Array] cssArray
    # @example
    #    cssAssemble(@css, @cssArray)
    #   - cssのみはid,clsの処理を追加
    #   - cssArrayの中身は処理しない
    #   -＞ cssArrayに追加するときに処理するため    
    def cssAssemble(css, cssArray)      
      @nameList = []      
      newArr = cssAssembleInit css, cssArray
      cssAssembleLoop newArr
      @cssString.removeLastRET
    end

    # wether css dupliucated?
    # @param [String] name
    # @return [Bool]
    def isSameCSSName(name)
      @nameList.include? name
     end
    
    # output of css string
    def showCssString
      cssStringInit
      cssAssemble @css, @cssArray
    end

    # ###### add member ############
    # @param [String] memberString
    def addMemberString (memberString)
      KString.isString? memberString
      @memberStringArray << memberString
    end
    
    # add css as member
    # @note member shold be based on JW class
    # @param [JW] member
    # @example
    #   <html>
    #   <head>
    #   </head>
    #   </html>
    def addMember (member)
      if member.is_a? JW 
        addJS(member)
        addHTML(member)
        addCSSmember(member)
      end
    end
    
    # add css as  member
    # @param [CSS] member
    def addCSSmember(member)   
      unless member.cssArray.empty?
        @cssArray.append member.cssArray
      end
      @cssArray.append member.css
    end
    
    # override ###
    def addHTML(member)
      member.assembleHTML
      addMemberString member.templeteString
    end
    
    # override ###
    def addJS( member )
      # implement at class JW_CSS_JS
      member # just write for reek warnig
    end
    
    # add css as members
    # @param [Array<JW>] members 
    def addMembers (*members)
      members.each do |obj| 
        self.addMember obj
      end
    end

    
    
    #########  press ###########
    # override ###
    def assembleHTML
      if @tagManager.name.empty?
        @tagManager.name = @name        
      end
      makeTag
      makeResult
      memberAssemble
    end
    
    # override ###
    def assembleCSS
      @pressVal.templeteString = @templeteString
      applyCss
    end
    
    # override ###
    def assemble
      assembleHTML
      assembleCSS
   
    end
  end
end
