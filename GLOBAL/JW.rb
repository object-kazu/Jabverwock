require_relative "globalDef" 
require_relative "insertData"  

class JW

  def initialize
    @aData = InsertData.new
    @openString     = ""
    @closeString    = ""
    @templeteString = ""
    @memberString   = []
    
  end

  attr_accessor :aData

  def to_s
    "#{@aData}, #{@openString}, #{@closeString}, #{@templeteString}, #{@memberString}" 
  end

  
  def assemble
    makeTag
    makeResult
  end

  def makeTag
    
  end

  def makeResult
    
  end

    
end


# a = InsertData.new
# a.label = "adf"
# p a
__END__


