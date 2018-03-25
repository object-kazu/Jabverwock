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
  class JWS < JW
    
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
          ans = jwKls
        end
        ans
      end

      def makeStringFrom(arr)
        arr.inject(""){ |res,a| res << a + "\n" }
      end
      
      def addMember(arr)
        members = []
        arr.each{ |a|
          if a.is_a? Array
            arr = addMember a
            child = makeStringFrom arr
            membersLast = addChild members.pop, child
            members << membersLast
          else
            members << transrate(a)
          end
        }
        members
      end
      
      def addChild(parentString,childString)
        #parentStringの中にchildStringを入れる
        parentString.gsub(/>\n.*<\//, ">\n#{childString}<\/")
      end
      
      # @param [Array] arg  like [a,b,[c,d],e]
      # <a>
      # </a>
      # <b>
      # <c>
      # </c>
      # <d>
      # </d>
      # </b>
      # <e>
      # </e>
      # []: express child
      def build(arg)
        res = ""
        arg.each{ |a|
          # if a.is_a? Array
          #   p "arraying"
          #   addChild parent, a
          # else
          #   parent = a
          # end
          # コレじゃ a が２回翻訳される！
          res << transrate(a)+"\n"
        }
        res.chomp
      end
      
    end

  end


end
