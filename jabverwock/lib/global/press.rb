module Jabverwock
  using StringExtension
  
#  // export html & css
# let EXPORT_TEST_Dir = "/Users/shimizukazuyuki/Desktop/index/"
# let EXPORT_TEST_File = "result.html"

# // export js
# let EXPORT_TEST_JS_Dir = "/Users/shimizukazuyuki/Desktop/index/"
# let EXPORT_TEST_JS_File = "result.js"

  $EXPORT_TEST_Dir = "/Users/shimizukazuyuki/Desktop/index/"
  $EXPORT_TEST_File = "resultRuby.txt"
  
  # This class is making HTML, CSS, JS code
  class Press
    
    attr_writer  :templeteString
    attr_reader  :resultString
    attr_accessor :exportPath, :exportFile
    
    def initialize
      # js

      # html & css
      @templeteString = "" #// Labelによる書き換え前のStringを保持
      @resultString = "" # // Labelによる書き換え後の最終String

      @exportPath = $EXPORT_TEST_Dir
      @exportFile = $EXPORT_TEST_File
      
    end

    # for confirmation and test method
    def showTempleteString
      @templeteString
    end

    def isResultStringEmpty
      @resultString == "" ? true : false 
    end
    
    def initResutString
      @resultString = ""
      @resultString = @templeteString.dup
    end

    def insertLabelData(label:, data:)
      KString.isString?(label)
      KString.isString?(data)
      
      targetString = label.variable
      dataPlusTargetString = targetString + data
      @resultString.gsub!(targetString, dataPlusTargetString)
    end
    
    def labelDataPair?(p)
      if !p.is_a?(Hash)
        p "pair is hash, like {label:, data:}"
        raise RuntimeError
      end        
    end

    
    def insertData(insertData)
      labelDataPair?(insertData)
      insertLabelData(label: insertData[:label], data: insertData[:data])
    end

    def insertDataList(*insertData)
      insertData.each do |i| 
        insertData(i)
      end
    end

    def removeAllLabel
      @resultString = @resultString.gsub(/##LABELSTART##.*?##LABELEND##/,"")
    end
    
    def withInsert(insertData)
      labelDataPair?(insertData)
      initResutString
      insertData(insertData)
      removeAllLabel
      core
    end

    def withInsertEach(insertData)
      initResutString
      
      insertData.each do |i|
        insertData(i)
      end
      
      removeAllLabel
      core
    end
    
    #  // templeteString -> resultString -> export
    def core
      pathName = @exportPath + @exportFile

      File.open(pathName, "w") do |f| 
        f.puts @resultString
      end
      
    end

    #### css ####
    def isExistHeadTag
      @templeteString.include?("<head") && @templeteString.include?("</head>")
    end

    def applyStyle(style)
      if isExistHeadTag
        @templeteString.gsub!(/<\/head>/, "#{style}</head>")
      end
    end

    
  end
end

