require "tabbing/tabbing"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
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

      @exportPath = ""
      @exportFile = "" 
      
    end

    # for confirmation and test
    def showTempleteString
      @templeteString
    end
    
    # whether exsit of result string
    # @return [Bool] empty is true
    def isResultStringEmpty
      @resultString == "" ? true : false 
    end
    
    # initialize resutltStrig
    def initResutString
      @resultString = ""
      @resultString = @templeteString.dup
    end
    
    # insert label and data
    # @param [String] label data label
    # @param [String] data 
    # @example
    #  i = "a".varIs ",again"
    #  insertDataList(i)
    #  => $LABEL_INSERT_START + "a" + $LABEL_INSERT_END + ",again"
    def insertLabelData(label:, data:)
      KString.isString?(label)
      KString.isString?(data)
      
      targetString = label.variable
      dataPlusTargetString = targetString + data
      @resultString.gsub!(targetString, dataPlusTargetString)
    end
    
    # pair should be hash
    # @param [Hash] p
    # @example
    #   {label:, data:}
    def labelDataPair?(p)
      if !p.is_a?(Hash)
        p "pair should be hash, like {label:, data:}"
        raise RuntimeError
      end
      true
    end

    # insert data to labeling strings
    # @param [Hash] insertData insertData is hash, {label:, data:}
    def insertData(insertData)
      labelDataPair?(insertData)
      insertLabelData(label: insertData[:label], data: insertData[:data])
    end
    
    # insert data
    # @param [Array<Hash>] insertData
    def insertDataList(*insertData)
      insertData.each do |i| 
        insertData(i)
      end
    end
    
    # arrange resultString
    def removeAllLabel
      @resultString = @resultString.gsub(/##LABELSTART##.*?##LABELEND##/,"")
    end
    
    # main function to insert data to label
    # @param [Hash] insertData 
    def withInsert(insertData)
      labelDataPair?(insertData)
      initResutString
      insertData(insertData)
      removeAllLabel
      core
    end
    
    # main function to insert data to label
    # @param [Array<Hash>] insertData call function withInsert
    def withInsertEach(insertData)
      initResutString
      
      insertData.each do |i|
        insertData(i)
      end
      
      removeAllLabel
      core
    end
    
    #  templeteString -> resultString -> export
    def core
      pathName = @exportPath + @exportFile
      
      if pathName == ""
        current = ENV['PWD']
        pathName = current + "pressed"
        p 'path is incorrect, pressed txt is saved at following directory,'
        p pathName
      end

      #builder tag remove
      @resultString.gsub!(/<builder>\n<\/builder>/, "")
      
      #tabbing
      tabbing = Tabbing.new
      tabbing.readLine @resultString
      
      File.open(pathName, "w") do |f| 
        f.puts tabbing.tabbedTxt
      end
    end

    def coreExportCss(cssPath)
      
      pathName = @exportPath + cssPath

      #@resultString から<style> ~~ </style>を抜き出す
      cssContent = @resultString[/<style>.*<\/style>/m]
      @resultString.gsub!(/<style>.*<\/style>/m, "") #resultStringから消去
      
      cssContent.gsub!(/<style>/,"")
      cssContent.gsub!(/<\/style>/,"")
      File.open(pathName, "w") do |f| 
        f.puts cssContent
      end

      core
      
    end
    
    # whether head tag exist
    # @return [Bool] if head tag exist return true
    def isExistHeadTag
      @templeteString.include?("<head") && @templeteString.include?("</head>")
    end
    
    # css insert to head tag
    # @param [CSS] style
    def applyStyle(style)
      if isExistHeadTag
        @templeteString.gsub!(/<\/head>/, "#{style}</head>")
      end
    end

    
  end
end

