require "global/globalDef"
require 'tabbing/tabbingBase'
require 'tabbing/tabbingCSS'
require 'tabbing/tabbingJS'
  

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension


  # add tab arrange to html, css, js file.
  class Tabbing < TabbingBase

    attr_reader :elmArray, :tagArray
    
    def initialize
      super
      @multiTagList = KSUtil.multiTags
      @multiTagList += KSUtil.tableTags
      
    end

    ######## mainLoop ######

    def footPrint
      "tabbing read"
    end
    
    def mainLoop     
      #css -> extract -> cssTabbing
      #js -> extract -> jsTabbing
      #html -> loop
      #css replace
      #js replace
      
      ## <li_mult>i rename to <li> after tabbing.
      # if @name == "li_multi"
      #   @name = "li"
      # end

      
      
      cssStatement = cssTabbing
      jsStatement = jsTabbing
      
      htmlLoop
      
      replaceStyleTagConstantTo cssStatement
      replaceScriptConstantTo jsStatement

      # replace_li_multi
    end

    def htmlLoop
      while @elmArray.count > 0
        target = @elmArray.first
        
        if isMultiOpenTag target
          shiftPlusTab
          
        elsif isMultiCloseTag target
          minusTabShift
          
        else
          shiftMain
        end
      end    
    end
    
    # def replace_li_multi
    #   @result.gsub!(/li_multi/, "li")
    # end
    
    ######## css treatment  ######
    #<style>~</style>を抽出して、STYLE_TAG_EXTRACTEDに置き換えるー＞整形したテキストをあとでreplace

    {:startIndex => "isStyle", :endIndex => "isCloseStyle"}.each do |name,method|
      define_method name do
        @elmArray.each_with_index do |v,index|
          return index if send(method,v)
        end          
      end
    end
    
    
    def extractStyle

      index = [startIndex,endIndex]

      return "" unless KString.isIntegerIndex index
      
      insertStyleTagConstant index.first
      range = KString.sliceRange index
      @elmArray.slice!(range)
      
    end

    def cssTabbing
      TabbingCSS.new.tabbedArrFrom extractStyle      
    end
    
    def insertStyleTagConstant(index)
      @elmArray.insert index, STYLE_TAG_EXTRACTED
    end

    def replaceStyleTagConstantTo(str)
      num = tabNumberAtLineWith STYLE_TAG_EXTRACTED
      ans = KString.addTabEachArray str, num
      @result.gsub!(STYLE_TAG_EXTRACTED, ans)
    end
        
    def tabNumberAtLineWith (str)
      @result.each_line { |l|
        if l.include? str
          return l.count "\t"
        end
      }
    end
    
    ######## js treatment   ######
    {:startScriptIndex => "isScript", :endScriptIndex => "isCloseScript"}.each do |name,method|
      define_method name do
        @elmArray.each_with_index do |v,index|
          return index if send(method,v)
        end          
      end
    end

    def extractScript
      index = [startScriptIndex, endScriptIndex]

      return "" unless KString.isIntegerIndex index
      
      insertScriptTagConstant index.first
      range = KString.sliceRange index
      @elmArray.slice!(range)    
    end

    def jsTabbing
      TabbingJS.new.tabbedArrFrom extractScript
    end

    def insertScriptTagConstant(index)
      @elmArray.insert index , SCRIPT_TAG_EXTRACTED
    end

    def replaceScriptConstantTo(str)
      num = tabNumberAtLineWith SCRIPT_TAG_EXTRACTED
      ans = KString.addTabEachArray str, num
      @result.gsub!(SCRIPT_TAG_EXTRACTED,ans)    
    end
    
  end
end
