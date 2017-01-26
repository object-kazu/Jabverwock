require "./globalDef"# => true
require "./TagAttribute"# => true

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
       str += $SPC 
    end
    str
  end
    
  def openString
    addID
    addCls
    
    
    @tempOpenString = "<" + @name + ">"
  end

  def closeString
    
    @tempCloseString = "</" + @name  + ">"
  end
  
end

__END__

 // br
        if isBRTag {return ""}
     
