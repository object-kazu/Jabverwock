require "global/globalDef"

require "global/jw"
require "global/jw_CSS"
require "global/jw_CSS_JS"
require "global/jw_CSS_OPAL_JS"

require "js/jsObject"
require "opal/opalFileReader"
require "css/css"



# structDescript.rbを改良する
# Arrayで構造化する
# class method  とする
# jws{
# [html,
#  [header,
#   [title],
#   body,
#   footer
#  ]  
# ]
# }

# ->
# <html>
#    <header>
#      <title></title>
#    </header>
#    <body>
#    </body>
#    <footer>
#    </footer>
# </html>

# 合成可能
# jws_header = jws{...}
# jws_body = jws{...}
# jws{
#   jws_header
# jws_body
# }

module Jabverwock
  
  class JWS < JW_CSS_OPAL_JS
    
    def initialize
      super
      @parent = []
    end
    
    # class method
    PREFIX_INDEX = "index"
    
    class << self
            
      def transrate(jwKls)
        ans = ""
        if jwKls.is_a? JW
          ans = jwKls.tgStr
        else
          ans = jwKls.chomp
        end
        ans
      end

      def makeStringFrom(arr)
        arr.inject(""){ |res,a| res << a + "\n" }
      end
      
      # @param [Array] arg  like [a,b,[c,d],e]
      # []: express child
      # @return [String] tgStr
      def buildToString(arr)
        members = []
        
        arr.each{ |a|
          if a.is_a? Array
            child = buildToString a
            membersLast = addChild members.pop, child
            members << membersLast
          else
            members << transrate(a)
          end
        }
        makeStringFrom members
      end

      def build(arr)
        ans = buildToString arr        
        v = JW_CSS_OPAL_JS.new
        v.name = "builder" # make builder tag, this tag is remove at press class, function core.
        v.templeteString = ans
        v
      end
      
      def addChild(parentString,childString)
        #parentStringの中にchildStringを入れる
        parentString.gsub(/>\n.*<\//, ">\n#{childString}<\/")
      end
      
      
    end

  end


end
