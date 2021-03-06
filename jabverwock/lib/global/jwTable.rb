require "global/globalDef"
  
require "global/jw_CSS_JS"
require "global/jwMulti"
require "global/jwSingle"
require "css/css"



module Jabverwock
  using StringExtension  
  using ArrayExtension
  using SymbolExtension
  
  # this class express table
  class JWTable < JWMulti

    # attr_accessor  :headerList
    attr_reader :rows, :headerList
    
    def initialize(style=$MULTI)
      super
      @caption    = ""
      @headerList = []
      @rows   = []

      @name = "table"
      @tagManager.name = @name
      @js.setTagName @name

    end
    
    # add caption to table
    # @param [String] str caption
    def caption(str)
      @caption = str
      self
    end
    
    # set header list
    # @param [String] str 
    def headerList(str)
      @headerList = str
    end
    
    # set caption
    def addCaption
      unless @caption.empty?
        c = TableCaption.new
        c.content = @caption
        @childStringArray << c.tgStr
      end 
    end

    def addTableHeader
      if @headerList.count > 0
        headerStr = TableHeader.new.tgStr
        headerStr << tableHeaderListTreat
             
        tr = TableRow.new.contentIs headerStr
        @childStringArray << tr.tgStr
      end
    end

    def tableHeaderListTreat
      @headerList.inject("") do |str,hl|
        h = TableHeader.new.contentIs hl
        str << h.tgStr
      end      
    end
    
    
    def dataTreatment
      if KSUtil.isDoubleArray @rows
        addTableDataList @rows
        return true # confirm code,for test
      else
        addTableData(@rows)
        return false # confirm code, for test
      end
    end
    
    
    # data -> [[1,1,1],[1,1,1]]
    def addTableDataList(arr)
      addGeneral arr, "addTableData"      
    end
    
    def addRows (*arr)
       addGeneral arr, "addRowEach"
    end

    def addGeneral(arr, function)
      unless arr[0].is_a? Array
        return send(function, arr)
      end
      
      arr.each do |a|
        send(function, a)
      end  
      
    end
    
    # data -> [1,1,1]
    def addTableData(arr)
      if arr.count > 0
        tr = TableRow.new.contentIs dataString(arr)
        @childStringArray << tr.tgStr
      end
    end
    
    def dataString(arr)
      arr.inject("") do |ds, hl|
        ds += TableData.new.tgStrWithContent hl
      end
    end
    
    def addRowEach (arr)
      @rows << arr
    end
    
    # override ###
    def assembleHTML
      nameCheck
      makeTag
      addCaption
      addTableHeader
      dataTreatment     
      makeResult
      memberAssemble
      insertScript
    end

    def nameCheck
      if @tagManager.name.empty?
        @tagManager.name = @name        
      end
    end
    
    
    def insertScript
      return unless isExistBodyTagAtTempleteString
      return if     isExistScriptTagAtTempleteString
      return unless isExistScriptContentAtTempleteString

      insertScriptToBody
    end
    
  end    
    
  # table caption express
  class TableCaption < JWSingle
    def initialize(style=$SINGLE)
      super
      @name = "caption"
      @js.setTagName @name
    end
  end
  
  # TR tag express
  class TableRow < JWMulti
    def initialize(style=$MULTI)
      super
      @name = "tr"
      @js.setTagName @name
    end
    
  end
  
  # TH tag express
  class TableHeader < JWSingle
    def initialize(style=$SINGLE)
      super
      @name = "th"
      @js.setTagName @name
            
    end
  end
  
  # TD tag express
  class TableData < JWSingle

    def initialize(style=$SINGLE)
      super
      @name = "td"
      @tagManager.name = @name
      @js.setTagName @name

    end
    
    ## override ##
    def tgStr
      treatContentToTag @content
      assemble
      @templeteString
    end

    def tgStrWithContent(str)
      @content = str
      tgStr      
    end

    
    # content = "test".rowSpan(2) --> <td rowspan="2">test</td>
    # content = "test".colSpan(2) --> <td colspan="2">test</td>
    def treatContentToTag (str)
      treatGeneral str, $ROW_SPAN, :rowspan
      treatGeneral str, $COL_SPAN, :colspan
    end

    def treatGeneral(str, target, targetSym)      
      if str.include? target
        t = str.split target
        number = t.last.to_i
        @tagManager.tagAttr(targetSym, number.to_s)
        @content = t.first
      end
    end
    
    def setRowSpan (number)
      if number.is_a? Integer
        @tagManager.tagAttr(:rowspan, number.to_s)      
      end
      self
    end

    def setColSpan (number)
      if number.is_a? Integer
        @tagManager.tagAttr(:colspan,number.to_s)        
      end
      self
    end
        
  end
 
end
