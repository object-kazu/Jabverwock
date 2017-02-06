#require_relative "jw"
require '../../lib/global/jwCSS'  

module Jabverwock
  using StringExtension
  class JWSingle < JWCSS
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
