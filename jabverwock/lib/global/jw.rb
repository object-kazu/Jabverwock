require "global/globalDef"
require "global/tagManager"
require "global/press"
require "global/structDescript"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # this class is base html class 
  class JW

    attr_accessor :name, :aData, :templeteString, :pressVal, :tagManager
    
    
    def initialize
      @name           = self.name
      @aData          = "".varIs("")
      @Data           = [] # insertData array
      @openString     = ""
      @closeString    = ""
      @templeteString = ""
      @memberStringArray   = []
      @pressVal       = Press.new ## input -> templeteString, output -> resultString
      @tagManager     = TagManager.new
      @isWithBreak    = false
    end

    def attrWithSymbolsArray(tag)
      return unless tag.is_a? Array
      tag.each do |t|
        return unless t.is_a? Symbol
        attrSymbol t
      end
      self
    end

    def attr(tag, *val)
      return unless tag.is_a? Symbol

      arr = Array(tag).append val
      
      arr.each_with_index do |v, index|
        if KSUtil.isDoubleUnderBarSymbol v    
          attrSymbol v
          next
        end

        if v.is_a? Symbol
          unless index + 1 >= arr.count
            @tagManager.tagAttr v, arr[index + 1]
            jsAttrForSymboleStringData v, arr[index + 1]
          end          
        end
      end
      
      self
    end

    def attrSymbol(tag)
      unless tag.is_a? Symbol
        p "tag class is #{tag}"
        assert_raise("tag should be symbol")
      end
      e = tag.divid
      @tagManager.tagAttr e[0], e[1]  
    end

    def jsAttrForSymboleStringData(symbol, string)
      #override at jwCssJs class
      p symbol
      p string
    end
    
    def withBreak()
      @isWithBreak = true
      self
    end
    
    # ex) @tagManager.Id = id
    # mainAttr.each do |attr| 
    #   define_method "#{attr}=" do |val|
    #     val = KString.checkString val
    #     eval "@tagManager.#{attr} = val"
    #   end
    # end    
    mainAttr =  [:id, :cls, :name]
    # ex) return @tagManager.Id
    mainAttr.each do |attr|      
      define_method "tag#{attr.capitalize}" do
        eval "@tagManager.#{attr}"
      end
    end
    
    def name
      self.class.to_s.split("::").last.downcase
    end
     
    def tgStr
      assemble
      @templeteString
    end

    def isSingleTag(isSingle)
      @tagManager.isSingleTag = isSingle  if KSUtil.isBool isSingle
    end

     ################ ID ################
    # def selectorID
    #   "#" + @tagManager.tagAttribute.id
    # end

    # def isExistID
    #   return false if @tagManager.tagAttribute.id.empty?
    #   true
    # end
    
    #  ################ cls  ################
    # def selectorCls
    #   "." + @tagManager.tagAttribute.cls
    # end

    # def isExistCls
    #   return false if @tagManager.tagAttribute.cls.empty?
    #   true
    # end
    
    
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    def memberAssemble
      if @memberStringArray.count > 0
         @templeteString += $RET
         ans = KString.stringArrayConectRET(@memberStringArray)
        
         @templeteString += ans
      end
      @memberStringArray = []
    end
    
    def makeTag
      @tagManager.withBreak = @isWithBreak
      @tagManager.openString
      @tagManager.closeString
    end

    def tag
      if @tagManager.name.empty?
        @tagManager.name = @name        
      end
      @tagManager.name
    end
    
    def assemble
      tag
      makeTag
      makeResult
      memberAssemble
      @pressVal.templeteString = @templeteString

    end

    # ## press ##
    
    def pressConfig(name:, dist:)
      @pressVal.exportFile = name
      @pressVal.exportPath = dist
    end
    
    def press
      prepPress
      pressDefault
    end

    def pressTo(name:,dist:)
      pressConfig(name: name, dist: dist)
      press 
    end
    
    def pressInsert(*insertData)
      if @pressVal.isResultStringEmpty
        prepPress
      end
      
      @pressVal.withInsertEach(insertData)
      pressDefault
      pressFingerPrint      
    end
    
    private
    def pressDefault
      @pressVal.core
      p "Press Done!"
      pressFingerPrint      
    end
    
    def pressFingerPrint
      @pressVal.resultString # 確認用の戻り値
    end
    
    def prepPress
      assemble      
      @pressVal.initResutString      
      @pressVal.removeAllLabel
    end
        
  end


end
