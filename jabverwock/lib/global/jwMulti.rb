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
      #     func addChildren (children : [JWObject]){
        
#         for c: JWObject in children {
#             addChild(child: c)
#         }
#     }

    end
    
    def addChildString(childString)
      childString = KString.checkString childString
      if childString.start_with?("\n")
        c = childString.gsub!(/\n/, "\n\t")
      else
        c = childString
      end
      
      @childStringArray << c
    end
      
    
    def makeResult

      @templeteString += @tagManager.tempOpenString + $RET
      
      childAssemble
      
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)

    end
    
    def childAssemble
      @childStringArray.each do |str| 
        @templeteString += $TAB + str
        @templeteString += $TAB + $RET
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
