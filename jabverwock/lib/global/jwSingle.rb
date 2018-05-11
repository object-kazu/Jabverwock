require "global/globalDef"
require "css/css"
require "global/jwOrigin"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is single line html, like HEADING tag
    class JWSingle < JWOrigin
    attr_accessor :content
    
    def initialize(style=$SINGLE)
      super
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
  
end

