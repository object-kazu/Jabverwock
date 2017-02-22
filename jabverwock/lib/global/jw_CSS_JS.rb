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


    def addCSS(member)
      if member.cssArray.count > 0
        @cssArray += member.cssArray
      end

      if member.css != nil
        @cssArray << member.css
      end
    end
    
    def addHTML(member)
      member.assemble
      addMemberString(member.templeteString)
    end
    
    def addJS(member)
      # importJSParameters(child: member)
    end
    
    
    def addMembers (*members)
      members.each do |obj| 
        self.addMember obj
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
