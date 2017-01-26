require "./GlobalDef"

class TagManager
  attr_accessor :name, :id, :cls
    
#   // tag attribute
#    var attr: TagAttribute = TagAttribute()
    
    
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
    
  end

  def addName
    if !@name.empty?
      st = "name=" + "\"" + @name + "\""
      addSpace
      @tempOpenString += st
    end
  end

  def addID
    if !@id.empty?
      st = "id=" + "\"" + @id + "\""
      addSpace      
      @tempOpenString  += st
    end
  end

  def addCls
    if !@cls.empty?
      st = "class=" + "\"" + @cls + "\""
      addSpace
      @tempOpenString  += st        
    end
  end

  def addSpace
    if !@tempOpenString.empty?
       @tempOpenString += SPC
    end
  end
  
  def openString
    addName
    addID
    addCls
    
    
    @tempOpenString
  end

  def closeString
    
    @tempCloseString
  end
  
end

# ~> LoadError
# ~> cannot load such file -- ../../GLOBAL/GlobalDef
# ~>
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /Users/shimizukazuyuki/.rbenv/versions/2.4.0/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
# ~> /var/folders/w8/tp2v81_s3f3g44st06_hgy0c0000gn/T/seeing_is_believing_temp_dir20170126-77808-13irvow/program.rb:1:in `<main>'
