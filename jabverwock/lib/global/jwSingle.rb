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
  
  class JWSingle < JW_CSS_JS
    attr_accessor :content
    
    def initialize
      super
      @content = ""
    end

    ## override ##
    def tgStr
      treatContentToSpan @content
      assemble
      @templeteString
    end

    def contentIs (str)
      @content = str
      self
    end

    
    # content = "test".rowSpan(2) --> <td rowspan="2">test</td>
    # content = "test".colSpan(2) --> <td colspan="2">test</td>
    def treatContentToSpan (str)

      return if str == nil
      
      if str.include? $ROW_SPAN
        t = str.split $ROW_SPAN
        setRowSpan(t[1].to_i)
        @content = t[0]
      end

      if str.include? $COL_SPAN
        t = str.split $COL_SPAN
        setColSpan(t[1].to_i)
        @content = t[0]
      end
      
    end
    
    def setRowSpan (number)
      if number.is_a?(Integer)
        @tagManager.tagAttr(:rowspan, number.to_s)      
      end
      self
    end

    def setColSpan (number)
      if number.is_a?(Integer)
        @tagManager.tagAttr(:colspan,number.to_s)        
      end
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

  class HEADING < JWSingle
    
    def initialize (level = 1)
      super()
      @content = ""
      @level = level
      insertLevel
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
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{@name}")
      end
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

