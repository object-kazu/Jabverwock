require 'global/globalDef'


# if $FOR_GEM  
#   require 'global/globalDef'
# else
#   require_relative '../../global/globalDef' 
# end


module Jabverwock
  using StringExtension
  using ArrayExtension
    
  # This class express element utility
  class ElementUtil
    def addEventListenerMain(content, event, func, useCaption)
      content.dot('addEventListener') + '('.inDoubleQuot(event) + $COMMA + func + useCaption + ')' + $JS_CMD_END
    end

    def spliteSympbolByUnderBar(sym)
      sym.to_s.split('_').first
    end

    def typeName(t)
      v = 'node'
      tArr = %w[Value Type Name]
      tArr.each do |a|
        if a.downcase == t.to_s
          return v << a
        end
      end
    end
  end


end
