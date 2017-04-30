if $FOR_GEM
  require "global/globalDef"
  
  
else
  require_relative "../global/globalDef" 

end




module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
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

    
    def setSelectors(inits)
      inits.each do |s|        
        setSelector s 
      end      
    end
    
    def setSelector(s)
      return if s == ""
      
      if s.is_a? String
        s = s.to_sym
      end
      
      return unless s.is_a? Symbol

      ans   = s.divid
      @id   = ans[1] if isID s
      @cls  = ans[1] if isCls s
      @name = ans[1] if isName s
    end

    def updateSelector(*inits)
      setSelectors inits
      self
    end

    def isID(s)
      isBase "id", s
    end

    def isCls(s)
      isBase "cls", s
    end

    def isName(s)
      isBase "name", s      
    end

    def isBase (i,s)
      s.to_s.include?(i) ? true : false            
    end
    
  end


#   a = JsBase.new()
  
end

