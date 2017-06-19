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

      
      # units and equality keep data like {:js1=> xxx, js2=> xxx}
      initSeq
      @units = {}    # => keep element hash (ex. doc.byID.innerHTML)
      @equality = {} #=> keep equality hash (ex. var id = test)
      @docHash = {}  #=> keep jsDocument hash (ex. doc.byID)
      
      setSelectors inits
    end

    ## numbering hash index
    def initSeq
      @sequence = 1.step
    end
    
    def seqHash(val)
      KSHash.seqHash val, @sequence.next
    end
    
    def removeJSPrefix(sym)
      str  = sym.to_s
      str.gsub(/js/,"").to_i
    end

    def gatheringOrder
      prep = @equality.update @units
      prep.update @docHash
    end
    
    def orders
      ord = gatheringOrder      
      sortedOrd = ord.sort {|(k1,v1),(k2,v2)| removeJSPrefix(k1) <=> removeJSPrefix(k2)}      
      ans = sortedOrd.flatten.inject([]) do |arr,v|
        arr << v unless v.is_a? Symbol
        arr
      end
      ans
    end

    
    # delegate
    def recBy (str)
      @units.update seqHash(str)
    end
    
    def record
      KSHash.firstHashValue @units
    end

    # def recordLast
    #   KSHash.lastHashValue @docHash
    # end
    
    def records
      KSHash.hashValues @units
    end

    def docRecords
      KSHash.hashValues @docHash
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

