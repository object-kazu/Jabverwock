require_relative "globalDef" 
require_relative "tagAttribute" 

class TagManager
  attr_accessor :name, :id, :cls, :tagAttribute
    
    
    
    # //script tag
    # var jsPath    : String    = ""
    # var jsPathPlusName :String   = ""
    # var jsFileName: String    = ""
    # var jsType    : String    = ""
  
  
  def initialize
    @tempOpenString = String.new
    @tempCloseString = String.new
    
    @name = String.new
    @id   = String.new
    @cls  = String.new

    @tagAttribute = TagAttribute.new
    
  end

  def addID
    if !@id.empty?
      st = "id=" + "\"" + @id + "\""
      @id = addSpace(st)
    end
  end

  def addCls
    if !@cls.empty?
      st = "class=" + "\"" + @cls + "\""
      @cls = addSpace(st)
    end
  end

  def addSpace(str)
    if !str.empty?
       str = $SPC + str
    end
    str
  end

  def isBrTag
    @name == "br" ? true : false
  end
  
  def openString
    addID
    addCls
    

    if isBrTag()
      return ""
    end
    
    @tempOpenString = "<" + @name + @id + @cls + ">"
  end

  def closeString
    if isBrTag
      return @tempCloseString = "<" + @name  + ">"
    end
    
    @tempCloseString = "</" + @name  + ">"
  end
  
end


__END__

