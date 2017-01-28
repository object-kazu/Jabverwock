require_relative "globalDef"

module Jabverwock
  class TagAttribute
    attr_accessor :aString
    
    def initialize
      @aString = String.new
    end

    def insertSPace(target)
      if @aString.empty?
        @aString = KS.checkString(@aString)
        @aString += target
      else
        @aString += $SPC + target
      end    
    end
    
    
    def templeteAdd (index: "", val: "")

      index = KS.checkString(index)
      val = KS.checkString(val)
      
      src = index + "=".inDoubleQuot(val)
      if !val.empty?
        insertSPace(src)
      end
    end
    
    
    def addLang(lang)
      lang = KS.checkString(lang)
      templeteAdd(index: "lang", val: lang)
    end

  end
end


  # a = TagAttribute.new
  # a.addLang("jj")
  # p a.aString + $DOUBLE_QUO

__END__

  // br
  if isBRTag {return ""}
    
    /// id, clsなどの指定が必要Tagはここより下に記入
    
    addID()
    addCls()
    addPath()
    addType()
    
    // script
    if isScriptTag() {
         return scriptTag()
       }
      
      
      // TODO: attribute Stringなので統一させたい！
      //<a>
        if isATag(){
             return ATag()
           }
          
          tempOpenString = "<" + name + id + cls + attr.aString + ">"
          return tempOpenString
          }
           
           private func ATag() -> String {
             if !href.isEmpty {
                  href = SPC + "href=" + href
                }
               if !target.isEmpty {
                    target = SPC + "target=" + target
                  }
                 
                 tempOpenString = "<" + name + id + cls + href + target + ">"
                 return tempOpenString
                 
           }
           }
