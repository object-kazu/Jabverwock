# require "global/globalDef"
 
# require "global/jw_CSS_JS"
# require "global/jwMulti"
# require "global/jwSingle"
# require "css/css"

#gem uninstall version
require "../../lib/global/globalDef"
require "../../lib/global/jwTable"
require "../../lib/global/jwSingle"
require "../../lib/global/jwMulti"
require "../../lib/global/jw_CSS_JS"


module Jabverwock
  using StringExtension  
  
  class JWTable < JWMulti

    attr_accessor :caption, :headerList, :dataList
    
    def initialize
      super
      @caption    = ""
      @headerList = []
      @dataList   = []

      @name = "table"
      @tagManager.name = @name
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

        tr.content = headerStr
        @childStringArray << tr.tgStr
      end
    end

    def dataTreatment
      if isDoubleArray(@dataList)
        addTableDataList(@dataList)
        return true # confirm code,for test
      else
        addTableData(@dataList)
        return false # confirm code, for test
      end
    end
    
    def isDoubleArray (data)
      data[0].is_a?(Array)
    end
    
    # data -> [[1,1,1],[1,1,1]]
    def addTableDataList(arr)      
      arr.each do |array|
        addTableData(array)
      end
    end
        
    # data -> [1,1,1]
    def addTableData(arr)
      dataString = ""

      if @headerList.count > 0
        tr = TableRow.new
        arr.each do |hl|
          dataString += tdTreatment(hl)
        end
        tr.content = dataString
        @childStringArray << tr.tgStr
      end
    end

    def tdTreatment (str)
      eachDataString = ""
      h = TableData.new
      h.content = str
      eachDataString += h.tgStr          
    end
    
    def addRow(*arr)
      unless arr[0].is_a?(Array)
        return addRowEach(arr)
      end
      
      arr.each do |a| 
        addRowEach a
      end  
    end
    
    def addRowEach (arr)
      if @dataList.count == 0
        @dataList = arr
        return @dataList
      end
      
      unless arr.is_a?(Array)
        @dataList += arr
        return @dataList
      end

      if arr[0].is_a?(Array)
        @dataList << arr
        return @dataList
      end
      
      @dataList = [@dataList, arr]
    end
    
    ### override ###
    def assemble
      if @tagManager.name == ""
        @tagManager.name = @name        
      end
      
      makeTag
      addCaption
      addTableHeader
      dataTreatment     
      makeResult
    end
    
  end    
    
  class TableCaption < JWSingle
    def initialize
      super
      @name = "caption"
    end
  end
  
  class TableRow < JWSingle
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
      if str.include?($ROW_SPAN)
        t = str.split($ROW_SPAN)
        setRowSpan(t.last.to_i)
        @content = t.first
        
        # setRowSpan(t[1].to_i)
        # @content = t[0]
      end

      if str.include?($COL_SPAN)
        t = str.split($COL_SPAN)
        setColSpan(t.last.to_i)
        @content = t.first
        
        # setColSpan(t[1].to_i)
        # @content = t[0]
      end
      
    end
    
    def setRowSpan (number)
      if number.is_a?(Integer)
        @tagManager.tagAttr(:rowspan, number.to_s)      
      end
      self
    end

    def setColSpan (number)
      if number.is_a?(Integer)
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
 # b.dataList = ["a","b"]
 # p b.pressDefault
 
end
