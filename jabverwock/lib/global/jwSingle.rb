# require "global/globalDef"
# require "global/jwCSS"
# require "css/css"

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jwTable"
require "../../lib/global/jwSingle"
require "../../lib/global/jwMulti"


module Jabverwock
  using StringExtension
  
  class JWSingle < JWCSS
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

    
    # content = "test".rowSpan(2) --> <td rowspan="2">test</td>
    # content = "test".colSpan(2) --> <td colspan="2">test</td>
    def treatContentToSpan (str)
      if str.include?($ROW_SPAN)
        t = str.split($ROW_SPAN)
        setRowSpan(t[1].to_i)
        @content = t[0]
      end

      if str.include?($COL_SPAN)
        t = str.split($COL_SPAN)
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

  singleList = ["P","A","B","BR","I","STRONG","BLOCKQUOTE","DT", "DD","HEADING","IMAGE",
                "LIST_ITEM","TITLE",]
  
  singleList.each do |list|
    Object.const_set list, Class.new(JWSingle){
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{name}")
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
  
  # c = JWCSS.new
  # p c.css
  # p c.cssArray
  # p c.pressDefault
  
end

