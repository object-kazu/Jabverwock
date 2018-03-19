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
        
      end
      
    end

  end


end
