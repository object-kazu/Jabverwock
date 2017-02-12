require '../../lib/global/jwCSS'  

module Jabverwock
  using StringExtension
  
  class JWMulti < JWCSS
    attr_accessor :childString
    
    def initialize
      super
      @childString = []
      
    end

    def addCihld(child)
#     // add child
#     func addChild (child : JWObject){
        
#         //js
#         importJSParameters(child: child)
#         // html
#         child.assemble()
#         self.addCihld(child: child.templeteString)
        
#         // css
#         if child.styleArray.count > 0{
#             styleArray.append(contentsOf: child.styleArray)
#         }
#         if child.style != nil{
#             styleArray.append(child.style)
#         }
        
#     }
      
    end

    def addChildren(children)
      #     func addChildren (children : [JWObject]){
        
#         for c: JWObject in children {
#             addChild(child: c)
#         }
#     }

    end
    
    def addChildString(childString)
          
#     func addCihld (child: String) {
        
#         let t = child.replacingOccurrences(of: RET, with: RET + TAB)
#         childString.append(t)
#     }

    end

    def assemble
    #     override func assemble() {
#         makeTag()
#         makeResult()
#     }
      
    end
    
    def makeResult
#     override func makeResult() {
#         templeteString += tagManager.tempOpenString + RET
        
#         childAssemble()
        
#         if !tagManager.tempCloseString.isEmpty {
#             templeteString += tagManager.tempCloseString
#         }
        
#         // 最後のRETを取り除く
#         templeteString = removeLastRET(str: templeteString)
#     }
      
    end
    
    def childAssemble
#     func childAssemble () {
#         for str in childString {
#             templeteString += TAB + str
#             templeteString += TAB + RET
#            }
#     }
      
    end
    
  end

  multiList = ["HEAD", "BODY","FOOTER","DIV","HTML","SCRIPT","TABLE",
               "PRE","STYLE"]
  
  multiList.each do |list|
    Object.const_set list, Class.new(JWMulti){
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
      end
    }
  end

  
#  p a = HEAD.new # => #<Car:0x007f878b8742d0 @name="car">

end
