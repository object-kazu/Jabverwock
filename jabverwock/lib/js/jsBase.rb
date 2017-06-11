if $FOR_GEM
  require "global/globalDef"
  
  
else
  require_relative "../global/globalDef" 

end

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # This class express JS basic class
  class JsBase
    attr_accessor :id, :cls, :name, :units
    
    #ex) initialize :id__test, :cls__sample, ":name__koko"
    def initialize(*inits)
      @obj = ""
      @id, @cls, @name = "", "",""

      @units = []
      @equality = []
    
      setSelectors inits
    end

    def orders
      @units + @equality
    end

    
    # delegate
    def recBy (str)
      @units << str
    end
    
    def record
      @units.first
    end

    def recordLast
      @units.last
    end
    
    def records
      @units
    end

    def setSelectors(inits)      
      inits.each do |s|        
        setSelector KSUtil.strinrgConvertSymbole s
      end      
    end

    def setSelector(s)
      return unless s.is_a? Symbol
      setID s
      setCls s
      setName s
    end
    
    def setID(s)
      if KSUtil.isID s
        @id = s.divid[1]
      end
    end

    def setCls(s)
      if KSUtil.isCls s
        @cls = s.divid[1]
      end
    end

    def setName(s)
      if KSUtil.isName s
        @name = s.divid[1]
      end
    end
    
    def updateSelector(*inits)

      setSelectors inits
      self
    end    
  end


# p  a = JsBase.new()
  
end

