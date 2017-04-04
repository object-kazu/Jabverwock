if $FOR_GEM
  
  require "global/globalDef"
  require "global/tagAttribute"

   
else

  require_relative "globalDef" 
  require_relative "tagAttribute" 
  
end




module Jabverwock
  using StringExtension
  class TagManager
    attr_accessor :name, :tagAttribute, :isSingleTag, :closeStringNotRequire, :tempOpenString, :tempCloseString #:id, :cls,
    attr_accessor :withBreak
    
    def initialize
      resetTags
    end

    ### reset tags #######
    def resetTags
      @tempOpenString = String.new
      @tempCloseString = String.new
      
      @name = String.new
      @doctype = "" #DOCTYPE only use
      
      @tagAttribute = TagAttribute.new
      @attributeString = String.new

      @isSingleTag = false
      
      #img, meta tag
      @closeStringNotRequire = false

      @withBreak = false
    end
    
    ####### add attribute #############################
    def tagAttr (tag, val)
      eval"@tagAttribute.add_#{tag}(val)"
      self
    end

    def addAttribute
      if !@tagAttribute.aString.empty?
        KString.isString?(@attributeString)
        @attributeString = KString.addSpace(@tagAttribute.aString)
        
      end
    end

    def setDocType(str)
      @doctype = str
    end
    
    #####  tag judgemnet ###########################
    def isHrTag
      @name == "hr" ? true : false
    end

    def isBrTag
      @name == "br" ? true : false
    end
    
    def isDocType
      @name == "doctype"? true: false
    end
    
    def isScriptTag
      @name == "script" ? true : false
    end

    ##### open and close string ###################
   
    def openStringReplace(of,with)
      @tempOpenString = KString.reprace(str: @tempOpenString, of: of, with: with)
    end
    
    def closeStringReplace(of, with)
      @tempCloseString = KString.reprace(str: @tempCloseString, of: of, with: with)
    end
    
    def openString
      if @name == ""
        assert_raise{
          p ">>> call no name"          
        }
      end
      
      if isDocType
        if @doctype == ""
          @doctype = "html" #default html5 
        end
        addAttribute
        @tempOpenString = "<" + "!DOCTYPE" + $SPC + @doctype + @attributeString + ">"
        return @tempOpenString
      end
      
      if isHrTag
        return ""
      end

      if isBrTag
        return ""
      end
                      
#         // script
#         if isScriptTag() {
#             return scriptTag()
#         }
            
      addAttribute
      @tempOpenString = "<" + @name + @attributeString + ">"
    end
    
    
    def closeString
      if @name == ""
        return ""
      end
      if isDocType
        return ""
      end
      
      if isHrTag
        @tempCloseString = "<#{@name}>"
        if @withBreak
          @tempCloseString << $BR
        end
        return @tempCloseString
      end
      
      if isBrTag
        return @tempCloseString = "<#{@name}>"
      end

      # closeStringNotRequire => bool値に変更する      
      # // not require
      # /// meta, img
      if closeStringNotRequire
        return "" # no close string
      end

      if isSingleTag
        return @tempCloseString = ""
      end
        
      @tempCloseString = "</#{@name}>"
      if @withBreak
        @tempCloseString << $BR
      end
    end
    
  end
end

__END__
