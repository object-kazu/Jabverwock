require_relative "jw"

module Jabverwock
  using StringExtension
  class JWSingle < JW
    attr_accessor :content
    
    def initialize
      super
      @content = ""
    end
        
    def makeResult
      @templeteString = @tagManager.tempOpenString + @content
      if !@tagManager.tempCloseString.empty?
        @templeteString += @tagManager.tempCloseString
      end
    end
    
  end
end
