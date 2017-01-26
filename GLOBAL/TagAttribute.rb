require "./GlobalDef"# => true

class TagAttribute
  def initialize
    @aString = String.new
  end

  def add(lang: "en")
    @aString += "Lang=".inDoubleQuot(lang)
  end

  
  
end

a = TagAttribute.new
a.add(lang: "jp")# => "Lang=\"jp\""

# class TagAttribute {
   
#     var aString = ""
   
    
#     func add (lang: LANG){
#         if lang == LANG.NO_LANG {return}
#         aString += SPC + lang.str()
#     }
    
#     func templeteAdd (index:String, val:String) {
#         if !val.isEmpty {
#             aString += SPC + index + "=".inDoubleQuo(inn: val)
#         }
#     }
    
#     func add(title : String){
#         templeteAdd(index: "title", val: title)
#     }
    
    
    
# }
