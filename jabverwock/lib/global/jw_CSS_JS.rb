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

    def initialize
      super      
      
    end
     
    
    ####### add child ############


    ## override
    def addJS(member)
      unless member.is_a?(JW_CSS)
        assert_raise{
          p "error, member should be JW_CSS"
        }
      end
      
      if member.tagManager.isJsAvailable
        self.tagManager.jsFileName = member.tagManager.jsFileName
        self.tagManager.jsType     = member.tagManager.jsType
        self.tagManager.jsPath     = member.tagManager.jsPath
      end      
    end
  end

  
   # a = JW_CSS_JS.new
   # p a
  # # a.css.name = "pp"
  # # a.css.color = "red"
  # #a.name = "test"
  # p a.pressDefault
    
  
end
