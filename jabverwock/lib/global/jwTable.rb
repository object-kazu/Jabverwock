# require_relative "globalDef" 
# require '../../lib/global/jwCSS'  
# require '../../lib/global/jwMulti'  

 require "global/globalDef"
 require "global/jwCSS"
 require "global/jwMulti"
 require "global/jwSingle"


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
    
    def addTableData(index)
      if @headerList.count > 0
        dataString = ""
        tr = TableRow.new
        dataList[index].each do |hl|
          h = TableData.new
          h.content = hl
          dataString += h.tgStr
        end

        tr.content = dataString
        @childStringArray << tr.tgStr
      end
    end
    
    ### override ###
    def assemble
      makeTag
      addCaption
      addTableHeader
      dataList.each_index do |ind|
        addTableData(ind)
      end
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
      @rowSpan = 0
      @colSpan = 0
      @INS_ROW_SPAN = "insert_row_span"
      @INS_COL_SPAN = "insert_col_span"
      
      @name = "td"
      @tagManager.tagAttr(:row_span, @INS_ROW_SPAN)
      @tagManager.tagAttr(:col_span, @INS_COL_SPAN)
      
    end
    
    
    def isRowSpan(str)
      str.include?($ROW_SPAN)
    end

    def isColSpan(str)
      str.include?($COL_SPAN)
    end

    def separateRowSpanNumber(str)
      str.split($ROW_SPAN)
    end

    def separateColSpanNumber(str)
      str.split($COL_SPAN)
    end


    def insertSpan
      if isContainRowOrColSpan
        a = @content.split($COMMA)
        fixRow_Col_Content(a)

        if @rowSpan > 0
          @tagManager.openStringReplace(@INS_ROW_SPAN, $SPC + "rowspan=#{rowSpan}")
        else
          @tagManager.openStringReplace(@INS_ROW_SPAN, "")          
        end
        
        if @colSpan > 0
          @tagManager.openStringReplace(@INS_COL_SPAN, $SPC + "colspan=#{colSpan}")
        else
          @tagManager.openStringReplace(@INS_COL_SPAN, "")          
        end
      end
    end
    
    def fixRow_Col_Content (str)
       a.each do |val| 
          if isRowSpan(val)
            s = separateRowSpanNumber(val)
            @rowSpan = s[1].to_i
          elsif isColSpan(val)
            t = separateColSpanNumber(val)
            @colSpan = t[1].to_i
          else
            @content = val
          end
       end
    end
    
    def isContainRowOrColSpan
      if @content.include?($ROW_SPAN)|| @content.include?($COL_SPAN)
        return true
      end
      return false
    end
    
  end

  ## override ##
  def assemble
    insertSpan
    makeResult
  end

  
  
end
