# require "global/globalDef"
# require "global/jw"
# require "css/Css"

# test
require '../../lib/global/globalDef'  
require '../../lib/global/jw'  
require '../../lib/css/css'  
require '../../lib/global/jw_CSS'  



module Jabverwock
  using StringExtension

  class JW_CSS_JS < JW_CSS # add css functions
    attr_accessor :js
    
    def initialize
      super      
      @js = [] ## [String]
    end
     
    ####### add child ############
    def isJsAvailable
      @js.empty? ? false : true
    end

    ## override
    def addJS(member)
      unless member.is_a?(JW_CSS_JS)
        assert_raise{
          p "error, member should be JW_CSS"
        }
      end
     
      ## koko now
      if member.isJsAvailable
        self.js = member.js
      end
    end

    def applyJS
      # js collect from child and member
      # js code import into <script> tag
      
    end
    
    ### override ###
    def assemble
      
      if @tagManager.name == ""
        @tagManager.name = @name        
      end
      makeTag
      makeResult
      memberAssemble
      applyCss(@css, @cssArray)
      applyJS
      
    end

    
  end

      #####  js           ###########################
    
#     /// js <script></script>に挟まれた文字列を取り出す
#     func extranctBetweenScriptTag (target: [String]) -> (scriptTag:[String], extract:[String]) {
#         /*
#          [0] = "<!DOCTYPE html type=\"text/javascript\" src=\"/Users/shimizukazuyuki/Desktop/index/test.js\">"
#          [1] = "<script type=\"text/javascript\" src=\"/Users/shimizukazuyuki/Desktop/index/test.js\">"
#          [2] = "\ttest\t"
#          [3] = "</script>"
         
#          */
        
#         var s : [String] = []
#         var e : [String] = []
        
#         var start = false
#         for st in target {
#             if st.contains("<script") {
#                 s.append(st)
#                 start = true
#                 continue
#             }
            
#             if st.contains("</script>") {
#                 s.append(st)
#                 start = false
#                 continue
#             }
            
#             if start {
#                 e.append(st)
                
#             }else{
#                 s.append(st)
#             }
            
            
#         }
#         return (scriptTag: s, extract: e)
#     }

    
#     /*
#      => isNeedJsSrc
#      <script type="text/javascript" src="/Users/shimizukazuyuki/Desktop/index/test.js"></script>
     
#      => InDocument
#      <script type="text/javascript"></script>
     
     
#      */
    
    # def isJsAvailable
    #   if !@jsExportType.empty? || !@jsExportPath.empty? || !@jsExportFileName.empty? # <script> available
    #     return true
    #   end
    #   return false
    # end

  
   # a = JW_CSS_JS.new
   # p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
    
  
end
