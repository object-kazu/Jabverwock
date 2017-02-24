# require "global/globalDef"
# require "global/jw_CSS_JS"
# require "css/css"

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jw_CSS_JS"


module Jabverwock
  using StringExtension
  
  class JWMulti < JW_CSS_JS
    attr_accessor :childStringArray
    
    
    def initialize
      super
      @childStringArray = []
      
    end

    def addChild(child)
      unless JW_CSS_JS === child
        assert_raise{
          p "child should be JW or JWCSS class "
        }
      end
      

      # css
      if child.cssArray.count > 0
        @cssArray += child.cssArray
      end

      if child.css != nil
        @cssArray << child.css
      end
            
      
      # html
      child.assemble
      addChildString(child.templeteString)
            
    end

    def addChildren(children)

      children.each do |c| 
        addChild c
      end
    end
    
    def addChildString(childString)
      childString = KString.checkString childString      
      @childStringArray << childString
    end
      
    
    def makeResult

      @templeteString += @tagManager.tempOpenString + $RET
      
      childAssemble
      
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)

    end

    def addTab(element)
      ans = ""
      element.lines{ |l|
        ans += "\t" + l
      }
      ans
    end
    
    def childAssemble
      tem = []
      @childStringArray.each do |t|
        tem << addTab(t)
      end
      tem.each do |a|
        @templeteString += a + $RET
      end
    end
    
  end

  multiList = ["HEAD", "BODY","FOOTER","DIV","HTML","SCRIPT",
               "PRE","STYLE"]
  
  multiList.each do |list|
    Object.const_set list, Class.new(JWMulti){
    
      attr_accessor :name
      
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{name}")
  
      end
    }
  end


  # a = JW_CSS_JS.new
  # p a
  
end
