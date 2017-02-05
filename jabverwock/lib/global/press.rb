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
  
  class Press
    
    attr_writer  :templeteString
    attr_reader  :resultString
    
    
    def initialize
      # js

      # html & css
      @templeteString = "" #// Labelによる書き換え前のStringを保持
      @resultString = "" # // Labelによる書き換え後の最終String
      
    end

    # for confirmation and test method
    def showTempleteString
      @templeteString
    end
    
    def initResutString
      @resultString = ""
      @resultString = @templeteString.dup
    end

    def insertLabelData(label:, data:)
      label = KString.checkString(label)
      data = KString.checkString(data)
      
      targetString = label.variable
      dataPlusTargetString = targetString + data
      @resultString.gsub!(targetString, dataPlusTargetString)
    end
    
    def insertData(insertData)
      KSUtil.labelDataPair?(insertData)
      insertLabelData(label: insertData[:label], data: insertData[:data])
    end

    def insertDataList(*insertData)
      insertData.each do |i| 
        insertData(i)
      end
    end

    def removeAllLabel
      ans = @resultString.gsub!(/##LABELSTART##.*?##LABELEND##/,"")
      if ans == nil
        return @resultString
      end
      @resultString = ans
    end
    
    def withInsert(insertData)
      KSUtil.labelDataPair?(insertData)
      initResutString
      insertData(insertData)
      removeAllLabel
      core(name: $EXPORT_TEST_File, dist: $EXPORT_TEST_Dir)
    end

    def withInsertEach(insertData)
      initResutString
      
      insertData.each do |i|
        KSUtil.labelDataPair?(i)
        insertData(i)
      end
      
      removeAllLabel
      core(name: $EXPORT_TEST_File, dist: $EXPORT_TEST_Dir)
    end

    
    #  // templateString -> resultString -> export
    def core(name:, dist:)
      name = KString.checkString(name)
      dist = KString.checkString(dist)

      exportResult(name: name, dist: dist)
    end
    
    def exportResult(name:$EXPORT_TEST_File, dist:$EXPORT_TEST_Dir)
      name = KString.checkString(name)
      dist = KString.checkString(dist)
      pathName = dist + name
      
      File.open(pathName, "w") do |f| 
        f.puts @resultString
      end

      @resultString

    end
    
  end

  
end

