require "global/globalDef"
require "global/tagAttribute"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #this class manage html tag
  class TagManager
    attr_accessor :name, :tagAttribute, :isSingleTag, :closeStringNotRequire, :tempOpenString, :tempCloseString
    attr_accessor :withBreak
    
    def initialize
      resetTags
    end

    ### reset tags #######
    def resetTags
      @tempOpenString, @tempCloseString, @name, @attributeString = "","", "", ""
      @doctype = "" #DOCTYPE only use
      @tagAttribute = TagAttribute.new
      @isSingleTag, @closeStringNotRequire, @withBreak = false, false, false
      
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

    def openStringDocType
        if @doctype.empty?
          @doctype = "html" #default html5 
        end
        addAttribute
        @tempOpenString = "<" + "!DOCTYPE" + $SPC + @doctype + @attributeString + ">"
    end
    
    def openString
      nameCheck
      
      return openStringDocType if isDocType
            
      if isHrTag || isBrTag
        return ""
      end
            
      addAttribute
      @tempOpenString = "<" + @name + @attributeString + ">"
    end

    def nameCheck
      if @name.empty?
        assert_raise{
          p ">>> call no name"          
        }
      end
    end
    
    def closeStringHrTag
        @tempCloseString = "<#{@name}>"
        if @withBreak
          @tempCloseString << $BR
        end
        @tempCloseString
    end

    def breakTreat
      if @withBreak
        @tempCloseString << $BR
      end
      
      @tempCloseString      
    end
    
    def closeString
      # closeStringNotRequire => bool値に変更する      
      # // not require
      # /// meta, img
      
      if @name.empty? || isDocType || isSingleTag || closeStringNotRequire
        return @tempCloseString = ""
      end
      
      if isHrTag
        return closeStringHrTag
      end
      
      if isBrTag
        return @tempCloseString = "<#{@name}>"
      end

      @tempCloseString = "</#{@name}>"
      breakTreat      
    end
    
  end
end

__END__
