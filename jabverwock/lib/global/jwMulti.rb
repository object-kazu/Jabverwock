require_relative "globalDef" 
require '../../lib/global/jwCSS'  

module Jabverwock
  using StringExtension
  
  class JWMulti < JWCSS
    attr_accessor :childStringArray
    
    
    def initialize
      super
      @childStringArray = []
      
    end

    def addChild(child)
      unless JWCSS === child
        assert_raise{
          p "child should be JW or JWCSS class "
        }
      end
      
      # js
      # importJSParameters(child: child)

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

  multiList = ["HEAD", "BODY","FOOTER","DIV","HTML","SCRIPT","TABLE",
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

  
  # p a = HEAD.new # => #<Car:0x007f878b8742d0 @name="car">
  # p a.cssArray

  
end
