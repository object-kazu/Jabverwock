require "global/globalDef"
require "global/jwSingle"

module Jabverwock
  
  # this class express html comment 
  class COMMENT < JWSingle
    
    attr_accessor :content
    
    def initialize
      super
      @name = "comment"
      @tagManager.name = @name
    end
    
    # overide ##
    def makeTag
      @tagManager.comment = @content
      
      # remove content because content show in the tag
      # if not removed, tag is like that, <!-- coment --> coment
      @content = "" 
      @tagManager.openString
    end
    
  end

end

