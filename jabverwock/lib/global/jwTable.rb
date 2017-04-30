if $FOR_GEM
  require "global/globalDef"
  
  require "global/jw_CSS_JS"
  require "global/jwMulti"
  require "global/jwSingle"
  require "css/css"
  
  
else

#gem uninstall version
  require "../../lib/global/globalDef"
  require "../../lib/global/jwTable"
  require "../../lib/global/jwSingle"
  require "../../lib/global/jwMulti"
  require "../../lib/global/jw_CSS_JS"
  
end




module Jabverwock
  using StringExtension  
  
  class JWTable < JWMulti

    attr_accessor  :headerList
    attr_reader :rows
    
    def initialize
      super
      @caption    = ""
      @headerList = []
      @rows   = []

      @name = "table"
      @tagManager.name = @name
    end

    def caption(str)
      @caption = str
      self
    end
    
    def addCaption
      unless @caption.empty?
        c = TableCaption.new
        c.content = @caption
        @childStringArray << c.tgStr
      end 
    end


    def addTableHeader
      if @headerList.count > 0
        headerStr = ""
        tr = TableRow.new
        h0 = TableHeader.new
        headerStr += h0.tgStr
        
        
        headerList.each do |hl| 
          h = TableHeader.new
          h.content = hl
          headerStr += h.tgStr
        end
      
        tr.contentIs headerStr
        @childStringArray << tr.tgStr
      end
    end

    def dataTreatment
      if isDoubleArray(@rows)
        addTableDataList(@rows)
        return true # confirm code,for test
      else
        addTableData(@rows)
        return false # confirm code, for test
      end
    end
    
    def isDoubleArray (data)
      data[0].is_a?(Array)
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
      dataString = ""
      if arr.count > 0
        tr = TableRow.new
        arr.each do |hl|
          dataString += tdTreatment(hl)
        end
        tr.contentIs dataString
        @childStringArray << tr.tgStr
      end      
    end

    def tdTreatment (str)
      eachDataString = ""
      h = TableData.new
      h.content = str
      eachDataString += h.tgStr          
    end
    
    
    def addRowEach (arr)
      @rows << arr
    end
    
    ### override ###
    def assembleHTML
      if @tagManager.name.empty?
        @tagManager.name = @name        
      end
      makeTag
      addCaption
      addTableHeader
      dataTreatment     
      makeResult
      memberAssemble

      return unless isExistBodyTagAtTempleteString
      return if     isExistScriptTagAtTempleteString
      return unless isExistScriptContentAtTempleteString

      insertScriptToBody

      
    end
    
  end    
    
  class TableCaption < JWSingle
    def initialize
      super
      @name = "caption"
    end
  end
  
  class TableRow < JWMulti
    def initialize
      super
      @name = "tr"
    end
    
  end

  class TableHeader < JWSingle
    def initialize
      super
      @name = "th"
    end
  end

  class TableData < JWSingle

    def initialize
      super
      @name = "td"
      @tagManager.name = @name
    end
    
    ## override ##
    def tgStr
      treatContentToTag @content
      assemble
      @templeteString
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

  tableTagList = ["TABLE","TROW","THEAD","TDATA"]  
  tableTagList.each do |list|    
    obj = ""
    case list
    when "TABLE"
      obj = JWTable
    when "TROW"
      obj = TableRow
    when "THEAD"
      obj = TableHeader
    when "TDATA"
      obj = TableData
    end
        
    Object.const_set list, Class.new(obj){
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{name}")
      end
    }
  end

  
  # a = TableData.new
  # a.content ="test"
  # p a.tgStr
     
  
 # p a = TABLE.new
 # p b = JWTable.new
 # b.rows = ["a","b"]
 # p b.pressDefault
 
end
