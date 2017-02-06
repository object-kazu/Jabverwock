require "../global/globalDef"

module Jabverwock
  class CssProperty

    #path confirm
    #p $SPC
    
    # ex) @tagManager.Id = id
    # mainAttr =  [:id, :cls, :name]
    # mainAttr.each do |attr| 
    #   define_method "#{attr}=" do |val|
    #     val = KString.checkString val
    #     eval "@tagManager.#{attr} = val"
    #   end
    # end

    
    
#     // property
#     public struct property {
#         var Font        : FONT!
#         var Padding     : PADDING!
        
#         var Color       : String
#         var Opacity     : String
        
#         // FONT
#         public struct FONT {
#             var size : String
            
#             public init(fSize:String = EMPTY){
#                 self.size = fSize
#             }
            
#             func para() -> [(String,String)]{
#                 return [("font-size", size)]
#             }
#         }
        
#         // PADDING
#         public struct PADDING {
#             var padding         : String
#             var padding_top     : String
#             var padding_bottom  : String
#             var padding_left    : String
#             var padding_right   : String

#             public init (pd:String          = EMPTY,
#                          pd_top:String      = EMPTY,
#                          pd_bottom:String   = EMPTY,
#                          pd_left:String     = EMPTY,
#                          pd_right:String    = EMPTY){
                
#                 self.padding        = pd
#                 self.padding_top    = pd_top
#                 self.padding_bottom = pd_bottom
#                 self.padding_left   = pd_left
#                 self.padding_right  = pd_right
                
#             }
#             func para() -> [(String,String)]{
#                 return [("padding", padding),
#                         ("padding-top", padding_top),
#                         ("padding-bottom", padding_bottom),
#                         ("padding-left", padding_left),
#                         ("padding-right", padding_right)]
#             }
#         }
        
#         // property variable
#         var paras : [(String, String)] = []
        
#         // property init
#         public init(kFontSize:String = EMPTY, kColor:String = EMPTY,kOpacity:String = EMPTY,
#                     kPadding:String = EMPTY){
#             self.Font       = FONT(fSize: kFontSize)
#             self.Color      = kColor
#             self.Opacity    = kOpacity
#             self.Padding    = PADDING()
    
#         }
        
#         mutating func prepParams (){
#             let c: [(String,String)] = [("color", Color), ("opacity", Opacity)]
#             let f: [(String,String)] = Font.para()
#             let p: [(String,String)] = Padding.para()
            
#             paras.append(contentsOf: c)
#             paras.append(contentsOf: f)
#             paras.append(contentsOf: p)
            
#         }
        
#         mutating func resetParams () {
#             paras = []
#         }
#     }

  end



  
  
  
end

