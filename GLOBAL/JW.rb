require "./GlobalDef"

=begin
 HTML basic class

=end


class JW

  def initialize
    @aData = InsertData.new()
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


__END__

