if $FOR_GEM
  require "global/globalDef"
  require 'tabbing/tabbingBase'

else

  #test
  require_relative "../global/globalDef" 
  require_relative "tabbingBase" 

end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension

  # add tab arrange to html, css, js file.
  class TabbingJS < TabbingBase

    # <script>
    # 	document.write('hello world');
    # 	document.write('next world');
    # </script>
    
    
    
    def initialize
      super
    end
    
    def mainLoop
      while @elmArray.count > 0
        target = @elmArray.first

        if isScript target
          shiftPlusTab
        elsif isCloseScript target
          minusTabShift
        else
          shiftMain
        end
        
      end    
    end


    ## js original
    def isScript(tag)
      tag.include? "<script"
    end
    def isCloseScript(tag)
      tag.include? "</script"
    end
    

    def isAttList(tag)
      return true if !isScript(tag) || !isCloseScript(tag)
      false
    end
    
  end

   # p t = TabbingJS.new
end
