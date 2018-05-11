require "global/globalDef"
require "global/jw_CSS_OPAL_JS"
require "global/jw"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class express multi line html tag, like head, body etc.
  class JWOrigin < JW_CSS_OPAL_JS
    
    attr_accessor :childStringArray
    attr_reader :isMulti
    attr_accessor :content
    
    @isMulti = true
    def initialize(style=$MULTI)
      super
      setTagStyle(style)
      
      @content = ""      
      @childStringArray = []
      @css = CSS.new("#{@name}")
    end

    def setTagStyle(style)
      if style == $SINGLE
        @isMulti = false
      elsif style == $MULTI
        @isMulti = true
      else
        @isMulti = true
      end 
    end

    def check_Is_Multi
      unless @isMulti
        raise "do not use this method, single tag only"
      end
    end

    
    # add child element
    # @param [Object] child child is object based on JW class
    # @example
    #   jw = JW.new
    #   parent.addChild jw
    def addChild(child)
      check_Is_Multi
      
      # unless child.is_a? JW
      #   p "child is >> #{child.class} error: child should be JW, JW_CSS_JS or JW_CSS class "
      #   assert_raise{}
      # end
      
      # js
      addJS child

      # css
      addChildCSS child
                 
      # html
      addChildHTML child
            
    end
    
    # add child css
    # @param [Object] child child css object
    def addChildCSS(child)
      check_Is_Multi
      
      if child.cssArray.count > 0
        @cssArray += child.cssArray
      end

      if child.css ||= CSS.new("#{@name}")
        # child.updateCssName
        @cssArray << child.css
      end
    end
    
    # add child html
    # @param [Object] child child html object
    def addChildHTML(child)
      check_Is_Multi
      
      child.assembleHTML
      addChildString(child.templeteString)      
    end
    
    # add children = some child object
    # @param [Objects] children some child object
    # @example
    #      b = BODY.new
    #      c = HEAD.new
    #      multi.addChildren b, c
    def addChildren(*children)
      check_Is_Multi
      
      children.flatten.each do |c| 
        addChild c
      end
    end
    
    # add content of tag
    # @param [String] str content
    # @example
    #     HEAD.new.contentIs "headless"
    #    => <head>headless</head>
    def contentIs (str)
      if isMulti
        addChildString str        
      else
        @content = str
      end
      self
    end
    
    # add string to child object
    # @param [String] childString string
    def addChildString(childString)
      check_Is_Multi
      KString.isString? childString      
      @childStringArray << childString
    end
    
    # add strings to child object
    # @param [Array<String>] children Array of String
    def addChildStrings(*children)
      check_Is_Multi
      children.each do |c|
        addChildString c
      end
    end
    
    # make result => html, css, js
    def makeResult
      if isMulti
        makeResultForMulti
      else
        makeResultForSingle
      end

    end
    
    def makeResultForSingle
      @templeteString = @tagManager.tempOpenString + @content
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
    end
    
    def makeResultForMulti
        @templeteString += @tagManager.tempOpenString + $RET
        
        childAssemble
        
        if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
        end
        @templeteString = KString.removeLastRET(@templeteString)        
      
    end
    
    # assemble strings from child object
    def childAssemble
      @childStringArray.each do |a|
        @templeteString << a << $RET       
      end
    end
    
  end  
end
