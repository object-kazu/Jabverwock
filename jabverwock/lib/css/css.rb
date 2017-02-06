module Jabverwock
  class CSS
    attr_accessor :property, :cssName
    
    def initialize
      @cssName = ""  # css name
      @property = "" # css property
      @cssResultString = ""
      @property = CssProperty.new
    end

    def self.newWithJWObject(jwObject)
      if !jwObject.is_a?(JWObject)
        p "arg should be JWObject"
        raise RuntimeError
      end
      
      objc = self.new
      objc.cssName = jwObject.tagName
      #実装していないのでコメントアウト
      #      objc.property = jwObject.style.property

      objc
    end
        
    def Str
      @cssResultString = ""
      if cssName.empty?
        p "css name is empry. set cssName"
        raise RuntimeError
      end

      #接頭句
      @cssResultString += @cssName + $SPC + "{" + $RET
      
      
    end
#     func Str() -> String  {
#         var cssResultString = "" // init

#         /// nameがないものは出力しない
#         if cssName.isEmpty {
#             assertionFailure("no name")
#             return ""
#         }

#         // 接頭句
#         cssResultString += cssName + SPC + "{" + RET
        
#         self.property.resetParams()
#         self.property.prepParams()
#         for i in self.property.paras{
#             cssResultString += itemStr(name: i.0, value: i.1)
#         }

#         // 接尾句
#         cssResultString += "}"
#         return cssResultString
#     }


#     private func itemStr (name:String, value:String) -> String {
#         if value.isEmpty {
#             return ""
#         }
        
#         //exp)  background: #ffffff;
#         return name + COLON + SPC + value + SEMI_COLON + RET
#     }

    
# }

  end
end
