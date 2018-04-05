require "global/globalDef"
require "global/jw_CSS_OPAL_JS"
require "css/css"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is single line html, like HEADING tag
  class JWSingle < JW_CSS_OPAL_JS
    attr_accessor :content
    
    def initialize
      super
      @content = ""
      
      @name = self.class.name.downcase
      @css = CSS.new("#{@name}")

    end

    # override ##
    def tgStr
      # treatContentToSpan @content
      assemble
      @templeteString
    end

    def contentIs (str)
      @content = str
      self
    end
    
    # override ###
    def makeResult  
      @templeteString = @tagManager.tempOpenString + @content
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
    end
    
  end

  #This class express <h1>, <h2>, <h3>, <h4>, <h5>, <h6>
  class HEADING < JWSingle
    
    def initialize (level = 1)
      super()
      @content = ""
      @level = level
      insertLevel
      
      @css = CSS.new("#{@name}")
    end
    
    # set HEADING level
    def insertLevel
      @level = 1 if @level > 6
      @level = 1 if @level < 0
      
      @name = "h#{@level}"
      @js.setTagName @name

    end

    
  end
  
  singleList = KSUtil.singleTags

  singleList.each do |list|
    Object.const_set list, Class.new(JWSingle){}
  end

end

