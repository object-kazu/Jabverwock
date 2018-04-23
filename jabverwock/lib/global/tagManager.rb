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
    attr_accessor :comment
    
    def initialize
      resetTags
    end

    #  initialize tags
    def resetTags
      @tempOpenString, @tempCloseString, @name, @attributeString = "","", "", ""
      @doctype = "" #DOCTYPE only use
      @tagAttribute = TagAttribute.new
      @isSingleTag, @closeStringNotRequire, @withBreak = false, false, false
      @comment = ""
    end
    
    # add attribute
    # @param [String] tag tag name
    # @param [String] val value
    def tagAttr (tag, val)
      eval"@tagAttribute.add_#{tag}(val)"
      self
    end
    
    # add attribute string
    def addAttribute
      if !@tagAttribute.aString.empty?
        KString.isString?(@attributeString)
        @attributeString = KString.addSpace(@tagAttribute.aString)        
      end
    end
    
    # set doc type
    # @param [String] str doc type
    def setDocType(str)
      @doctype = str
    end
    
    # whether @name is Hr tag
    # @return [Bool]
    def isHrTag
      @name == "hr" ? true : false
    end
    
    # whether @name is Br tag
    # @return [Bool]
    def isBrTag
      @name == "br" ? true : false
    end
    
    # whether @name is doctype tag
    # @return [Bool]
    def isDocType
      @name == "doctype"? true: false
    end
    
    # whether @name is script tag
    # @return [Bool]  
    def isScriptTag
      @name == "script" ? true : false
    end

    def isComment
      @name == "comment"? true: false
    end
    
    # #### open and close string ###################
    # TODO refactoring with openStringReplace and closeStringReplace
    #
    # @example
    #  tm = TagManager.new
    #  tm.tempOpenString = "aaa"
    #  tm.openStringReplace("a","b")
    #  expect(tm.tempOpenString).to eq "bbb"
    def openStringReplace(of,with)
      @tempOpenString = KString.reprace(str: @tempOpenString, of: of, with: with)
    end
    
    # @example
    # tm = TagManager.new
    # tm.tempCloseString = "aaa"
    # tm.closeStringReplace("a","b")
    # expect(tm.tempCloseString).to eq "bbb"
    def closeStringReplace(of, with)
      @tempCloseString = KString.reprace(str: @tempCloseString, of: of, with: with)
    end
    
    # make doctype tag
    # default value is "html", if you want to change , set @doctype 
    def openStringDocType
        if @doctype.empty?
          @doctype = "html" #default html5 
        end
        addAttribute
        @tempOpenString = "<" + "!DOCTYPE" + $SPC + @doctype + @attributeString + ">"
    end

    def commentTag
      @tempOpenString = "<!-- #{@comment} -->"
    end
    
    # make open string, open string is like <p> and <html>
    def openString
      nameCheck
      return openStringDocType if isDocType
      return commentTag if isComment
      if isHrTag || isBrTag
        return ""
      end
            
      addAttribute
      @tempOpenString = "<" + @name + @attributeString + ">"
    end
    
    # whether name is empty?
    def nameCheck
      if @name.empty?
        assert_raise{
          p ">>> call no name"          
        }
      end
    end
    
    # TODO add test and refactoring closeStringHrTag and breakTreat
    def closeStringHrTag
      @tempCloseString = "<#{@name}>"
      breakTreat
        # if @withBreak
        #   @tempCloseString << $BR
        # end
        # @tempCloseString
    end
    
    # insert br tag if you want, set by @withBreak
    def breakTreat
      if @withBreak
        @tempCloseString << $BR
      end
      
      @tempCloseString      
    end
    
    # make close string like, </p> and </html>
    def closeString
      # closeStringNotRequire => bool値に変更する      
      # // not require
      # /// meta, img
      
      if @name.empty? || isDocType || isSingleTag || closeStringNotRequire || isComment
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
