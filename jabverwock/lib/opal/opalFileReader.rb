require 'systemu'

module Jabverwock
  
  # this class is treat opal file, that is import comiled file and insert script tag for opal file
  class OpalFileReader 
    attr_writer :opalPath
    attr_reader :opalFileName

    EXT_RUBY = '.rb'
    INSTALLED_OPAL_PATH = "/Users/shimizukazuyuki/ActiveProject/opalTest/opal"
    
    def initialize
      @opalPath = ""
      @opalFileName = ""
      @opalFilePath = ""
    end

    def readOpal
      readIn @opalPath
    end

    def isRubyCode(path)
      ex = File.extname(path)
      ex == EXT_RUBY ? true : false
    end
    
    def extractFileName(path)
      return "error, select ruby code" unless isRubyCode path
      @opalFileName = File.basename(path, EXT_RUBY)
    end

    def extractFilePath(path)
      @opalFilePath = File.dirname(path)
    end

    def extractFile path
      extractFilePath path
      extractFileName path
    end
    
    def readIn(path)
      extractFile path
      
      begin        
        exeCmd = %Q(opal -I #{INSTALLED_OPAL_PATH} --gem paggio --compile #{path} > "#{@opalFilePath}/#{@opalFileName}.js")
        systemu exeCmd
        
      rescue => e
        puts e
        puts '!!! Can not read file !!!'
      end
    end
        
    
  end

  a = OpalFileReader.new
  a.readIn("/Users/shimizukazuyuki/ActiveProject/opalTest/hellow.rb")
  p a.opalFileName

  
  
end

