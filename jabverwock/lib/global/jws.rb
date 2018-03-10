require "global/globalDef"

require "global/jw"
require "global/jw_CSS"
require "global/jw_CSS_JS"
require "global/jw_CSS_OPAL_JS"

require "js/jsObject"
require "opal/opalFileReader"
require "css/css"



# structDescript.rbを改良する
# Tab とRTで構造化する -> python like
# class method  とする
# jws{
# html
# \t header
# \t \t title
# \t body
# \t footer
#}

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

      
      # @return [Hash] {:index0 => "body", :index1 => "head"}
      def countArrayDepth(arr, depthIndex = 0, result=[])
        arr.each{ |s|
          if s.is_a?(Array)
            countArrayDepth s, depthIndex+1,  result
          else
            result << {"index#{depthIndex}": s}
          end
        }
        result
      end
      
      # @param [Symbol] key like :index0
      # @return [Int] tab number
      def extractTabNumber(key)
        k = key.to_s
        k.split(PREFIX_INDEX).pop.to_i
      end

      def addTab(str, numOfTab)
        ans = ""
        numOfTab.times{
          ans << "\t"
        }
        ans << str
      end

      def tabbing(target)
        ans = ""
        target.each{ |ind, val|
          t = extractTabNumber ind
           ans = addTab(val, t)
        }
        ans
      end
      
      def transrate(jwKls)
        if jwKls.is_a? JW
          jwKls.tgStr
        end
      end

      
      # @param [arg] hash like {:index0 => "body", :index1 => "head"}
      def build(arg)
        ans = arg.inject(""){ |res,s|
          res << transrate(s) + "\n"
        }
        ans.chomp
      end
      
    end

  end
end


