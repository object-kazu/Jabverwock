require_relative "jw"

module Jabverwock
  using StringExtension
  class JWSingle < JW
    attr_accessor :content
    
    def initialize
      super
      @content = ""
    end
    
    def addContentAt(insertData)
      KSUtil.is_InsertData(insertData)
      $LABEL_INSERT_START + insertData.label + $LABEL_INSERT_END + insertData.data
    end
    
    def makeResult
      @templeteString = @tagManager.tempOpenString + @content
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
    end
    
  end
end
