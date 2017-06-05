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
    attr_accessor :id, :cls, :name, :orders
    
    #ex) initialize :id__test, :cls__sample, ":name__koko"
    def initialize(*inits)
      @obj = ""
      @id, @cls, @name = "", "",""

      @orders = []
            
      setSelectors inits
    end
    
    # delegate
    def recBy (str)
      @orders << str
    end
    
    def record
      @orders.first
    end

    def recordLast
      @orders.last
    end
    
    def records
      @orders
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


#   a = JsBase.new()
  
end

