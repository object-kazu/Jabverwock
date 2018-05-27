require "global/globalDef"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension

  # tabbibg basic class
  class TabbingBase

    attr_reader :elmArray, :tagArray

    STYLE_TAG_EXTRACTED = "style tag is extracted\n"
    SCRIPT_TAG_EXTRACTED = "script tag is extracted\n"
    
    def initialize
      @multiTagList = %w(HTML HEAD BODY FOTTER)
      @elmArray  = []
      @result = ""
    end

    def showResultForTest
      @result
    end
    
    def tabbedTxt
      mainLoop
      @result.chomp # remove last return
    end

    def tabbedArr
      return "" if @elmArray.empty?
      
      mainLoop
      readLine @result
      @elmArray
    end


    def tabbedArrFrom(arr)
      readArray arr
      tabbedArr
    end
    
    ######### divid: txt -> line -> array  #######
    
    def fileReading(txt)
      KSUtil.fileReadingToArr txt, @elmArray
    end
        
    def readLine(str)
      str.each_line do |l|
        @elmArray << l      
      end
    end
    
    def readArray(arr)
      @elmArray = arr
    end

    ######## mainLoop ######
    def mainLoop
      #override method 
    end
    
    ######## HTML tag ######
    
    def isMultiOpenTag(tag)    
      return true if KSUtil.isOpenTag(tag) && !KSUtil.isCloseTag(tag) && isMultiTag(tag)
      false
    end

    def isMultiCloseTag(tag)
      return true if !KSUtil.isOpenTag(tag) && KSUtil.isCloseTag(tag)
      false
    end

    def isMultiTag (tag) # multi tag -> add tab
      @multiTagList.each do |t|
        return true if tag.include? t.downcase
      end
      false
    end


    #### for css #####
    def isStyle(tag)
      tag.include? "<style"
    end
    
    def isCloseStyle(tag)
      tag.include? "</style"
    end

    ##### for js #########
    def isScript(tag)
      tag.include? "<script"
    end
    
    def isCloseScript(tag)
      tag.include? "</script"
    end

    ######## control(increase, decrease) array and tab ######
    
    def plusTab
      @elmArray.map{ |a| "\t" << a }
    end

    def minusTab
      @elmArray.map { |a| a.sub /^\t/,"" }
    end
    
    def shiftMain
      @result << @elmArray.first
      @elmArray.shift    
    end
    
    def shiftPlusTab
      shiftMain
      @elmArray = plusTab
    end

    def minusTabShift
      @elmArray = minusTab
      shiftMain
    end
  end

end
