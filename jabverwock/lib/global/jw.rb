require "global/globalDef"
require "global/tagManager"
require "global/press"
require "global/structDescript"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  # This class is base html class 
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
    
    # add Array<Symbol> to @attrSymbol
    # @param [Array<Symbol>] tag tag is should be symbol array
    # @return [Array<Symbol>] 
    # @example
    #  attrWithSymbolsArray [:id, :cls]
    def attrWithSymbolsArray(tag)
      return unless tag.is_a? Array
      tag.each do |t|
        return unless t.is_a? Symbol
        attrSymbol t
      end
      self
    end
    
    # make pair with tag and value  
    # val is not enough, if tag is symbol combine with value used '__'
    # @example
    #  (:id , test) == (:id__test)
    # @param [Symbol] tag 
    # @param [String] val val is not enough
    # @return [Void]
    # @example
    #  JW.new.attr(:font_size, 10) => "<jw font-size="10">\n</jw>"
    #  JW.new.attr(:font_size__10) => "<jw font-size="10">\n</jw>"
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

    
    # set attribute sybmol
    # @param [Symbol] tag
    # @return [Void]
    # @example
    #  jw.attrSymbol :cls__sample
    #   "<jw class=\"sample\">\n</test>"
    def attrSymbol(tag)
      unless tag.is_a? Symbol
        p "tag class is #{tag}"
        assert_raise("tag should be symbol")
      end
      e = tag.divid
      @tagManager.tagAttr e[0], e[1]  
    end
    
    # override at jwCssJs class
    def jsAttrForSymboleStringData(symbol, string)    
      # p symbol
      # p string
    end
    
    # whether <br> tag need
    # # return [Bool] always return true
    def withBreak()
      @isWithBreak = true
      self
    end
    
    # @example
    #   @tagManager.Id = id
    #   mainAttr.each do |attr| 
    #    define_method "#{attr}=" do |val|
    #      val = KString.checkString val
    #      eval "@tagManager.#{attr} = val"
    #    end
    #   end    
    mainAttr =  [:id, :cls, :name]
    
    # @example
    #     return @tagManager.Id
    mainAttr.each do |attr|      
      define_method "tag#{attr.capitalize}" do
        eval "@tagManager.#{attr}"
      end
    end
    
    
    def name
      self.class.to_s.split("::").last.downcase
    end
    
    # just return tag strings
    # tag string is such as <p>hogehoge<p>
    # @return [String] tag string
    def tgStr
      assemble
      @templeteString
    end
    
    def isSingleTag(isSingle)
      @tagManager.isSingleTag = isSingle  if KSUtil.isBool isSingle
    end    
    
    # build tag string
    # @return [String]
    def makeResult
      @templeteString += @tagManager.tempOpenString + $RET
      if !@tagManager.tempCloseString.empty?
          @templeteString += @tagManager.tempCloseString
      end
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
    # build member tags
    # @example
    #   <head>
    #   </head>
    #   <body> // body tag is member of head tag
    #   </body>
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
    
    # @return [String] tag name
    def tag
      if @tagManager.name.empty?
        @tagManager.name = @name        
      end
      @tagManager.name
    end
    
    # collect informations of tag and build to make tag
    def assemble
      tag
      makeTag
      makeResult
      memberAssemble
      @pressVal.templeteString = @templeteString
    end

    ###### press ######
    
    # configure of press
    # @param [String] name file name
    # @param [Path] dist export path
    def pressConfig(name:, dist:)
      @pressVal.exportFile = name
      @pressVal.exportPath = dist
    end
    
    # generate file
    # require pressConfig
    def press
      prepPress
      pressDefault
    end
    
    # generate file
    # @param [String] name file name
    # @param [Path] dist export path
    def pressTo(name:,dist:)
      pressConfig(name: name, dist: dist)
      press 
    end
    
    # press with using variable
    # insert data into each varable
    # if not use pressInsert, variable just remove
    # @param [Any] insertData variable data
    # @return [String] pressed result
    def pressInsert(*insertData)
      if @pressVal.isResultStringEmpty
        prepPress
      end
      
      @pressVal.withInsertEach(insertData)
      pressDefault
      pressFingerPrint      
    end
    
    private
    # main method of pressing
    def pressDefault
      @pressVal.core
      p "Press Done!"
      pressFingerPrint      
    end
    
    # 確認用の戻り値
    def pressFingerPrint
      @pressVal.resultString 
    end
    
    # pretreat pressing
    # remove labels
    def prepPress
      assemble      
      @pressVal.initResutString      
      @pressVal.removeAllLabel
    end
        
  end


end
