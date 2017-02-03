require_relative "globalDef"

module Jabverwock
  using StringExtension
  class TagAttribute
    attr_accessor :aString
    
    def initialize
      @aString = String.new
    end

    def insertSPace(target)
      if @aString.empty?
        @aString = KString.checkString(@aString)
        @aString += target
      else
        @aString += $SPC + target
      end    
    end
    
    
    def templeteAdd (index: "", val: "")

      index = KString.checkString(index)
      val = KString.checkString(val)
      
      src = index + "=".inDoubleQuot(val)
      if !val.empty?
        insertSPace(src)
      end
    end
    
    
    def addLang=(lang)
      lang = KString.checkString(lang)
      templeteAdd(index: "lang", val: lang)
    end

  end
end



__END__
