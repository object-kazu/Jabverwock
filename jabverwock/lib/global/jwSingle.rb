if $FOR_GEM
  require "global/globalDef"
  require "global/jw_CSS_JS"
  require "css/css"
  
else
  #gem uninstall version
  require "../../lib/global/globalDef"
  require "../../lib/global/jw_CSS_JS"  
  require "../../lib/css/css"
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is single line html, like HEADING tag
  class JWSingle < JW_CSS_JS
    attr_accessor :content
    
    def initialize
      super
      @content = ""
      
      @name = self.class.name.downcase
      @css = CSS.new("#{@name}")

    end

    ## override ##
    def tgStr
      # treatContentToSpan @content
      assemble
      @templeteString
    end

    def contentIs (str)
      @content = str
      self
    end
    
    ### override ###
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
      # insertLevel
      
      @name = self.class.name.downcase
      @css = CSS.new("#{@name}")
    end

    def insertLevel
      @level = 1 if @level > 6
      @level = 1 if @level < 0
      
      @name = "h#{@level}" 
    end

    
  end
  
  singleList = KSUtil.singleTags
  
    singleList.each do |list|
    Object.const_set list, Class.new(JWSingle){
    
      # attr_accessor :name
      # def initialize
      #   super
      #   @name = self.class.name.downcase
      #   @css = CSS.new("#{@name}")
      # end
    }
  end

  
  
  # a = A.new
  # a.assemble
  # p a.templeteString

  
  # p a = P.new 
  # p b = B.new
  # p b.name
  # p b.css
  # p b.cssArray
  
  # c = JW_CSS_JS.new
  # p c.css
  # p c.cssArray
  # p c.pressDefault
  
end

