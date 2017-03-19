
if $FOR_GEM
  require "global/globalDef"
  require "global/tagManager"
  require "global/press"

else

  #test
  require_relative "globalDef" 
  require_relative "tagManager"  
  require_relative "press"

end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  
  class StructDescript

    attr_accessor :parArr, :parIndex
    
    def initialize
      @parArr = [] #親を覚えておく
      @parIndex = 0
      @resultString = ""
    end

    def structing(str)
      ans = prep str
      ans = arraying ans
      ans = readCoden ans
    end

    def expr (str)
      structing str
      res = showResult
      res.split("\n")
    end

    def prep (str)
      ans = str.gsub(/\t/," ")
      ans = ans.gsub(/\n/,"").gsub(/\s/, "")
    end

    def arraying (str)
      ans = str.gsub(/{/," #{$CHILD} ").gsub(/,/," #{$MEMBER} ").gsub(/}/," #{$ENDMARK} ")
      ans.split()
    end

    def isElement (str)
      return false if str == $CHILD
      return false if str == $MEMBER
      return false if str == $ENDMARK
      return true
    end
    
    def readCoden (arr)
      arr.each_with_index do |ele, index|
        break if index + 3 > arr.count
        
        l = arr[index]
        c = arr[index + 1]
        r = arr[index + 2]
        
        coden l,c,r        
      end
    end
        
    def coden(l, c, r)      
      if isElement l
        codenElemnt l,c,r
      elsif l == $MEMBER || l == $CHILD
      # nothing to do
        
      # ","  "a"  ","
      # ","  "a"  "{"
      # ","  "a"  "}"

      # "{"  "a"  "}"
      # "{"  "a"  ","
      # "{"  "a"  "{"

      elsif l == $ENDMARK
        codenEndMark l,c,r
      end
      
    end

    def codenElemnt (l,c,r)
      # "a"  ","  "b" 
      # "a"  "{"  "b"
      # "a"  "}"  ","
      # "a"  "}"  "}"

      case c
      when $CHILD     #ex) a { b
        recordResult addChild l,r
        recordPar l
      when $MEMBER    #ex0 a , b
        recordResult addMember l,r
      when $ENDMARK #ex) a, }, (,|})
        @parIndex += 1
        endMarkCoden r
      end
    end
    
    def endMarkCoden (lastCode)
      if lastCode == $ENDMARK #ex) a, }, }
        @parIndex += 1        
      end
      recordPar showPar @parIndex
    end
    

    def codenEndMark(l,c,r)
      # "}"  ","  "a"
      # "}"  "}"  ","
      # "}"  "}"  "}"
      if c == $MEMBER
        l = showPar @parIndex
        p "call ! #{l} and #{r}"
        recordResult addMember l,r
      end

      if c == $ENDMARK
        @parIndex += 1
      end
            
    end
    
    
    def showPar (index)
      pi = @parArr.count - index
      if pi < 0
        assert_raise()
      end
      @parArr[pi]
    end
    
    def recordPar (par)
      @parArr << par      
    end
    
    def recordResult (str)
      @resultString = str << @resultString
    end

    def showResult
      @resultString
    end
    
    def addMember(par, *mem)
      ans = ""
      mem.each do |m|
        ans << "#{par}.addMember(#{m})" << "\n"
      end
      ans
    end

    def addChild(par, *chi)
      ans = ""
      chi.each do |c|
        ans << "#{par}.addChild(#{c})" << "\n"
      end
      ans
    end
  end

  
  #p a = JW.new
  
end

