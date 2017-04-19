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
  class TabbingCSS < TabbingBase

    # script tag -> level 0
    # { , }      -> level 1
    #   nothing  -> level 2
    
    
    def initialize
      super
    end


    ## css original
    #override
    def mainLoop
      while @elmArray.count > 0
        target = @elmArray.first
        
        if isOpenPara(target) || isStyle(target)
          shiftPlusTab
        elsif isClosePara(target)|| isCloseStyle(target)
          minusTabShift
        else
          shiftMain
        end   
      end    
    end
    
    def isOpenPara(tag)
      tag.include? "{"
    end

    def isClosePara(tag)
      tag.include? "}"
    end

    def isAttList(tag)
      return true if !isOpenPara(tag) && !isClosePara(tag) && !isStyle(tag)
      false
    end
    

  end
# p t = TabbingCSS.new
end

