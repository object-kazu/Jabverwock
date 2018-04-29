require "global/jwSingle"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #this class express ["DOCTYPE","META", "IMG", "LINK", "INPUT"]
  class JWOneTag < JWSingle
    attr_accessor :doctype
    
    def initialize
      super
      @doctype = ""
    end
    
    # overide ##
    def makeTag
      @tagManager.setDocType @doctype
      @tagManager.openString
    end
    
    # overide ##
    def makeResult
      @templeteString = @tagManager.tempOpenString

      if @content.is_a? NilClass
        @content = ""
      end
      
      unless @content == ""
        @templeteString << @content
      end
            
      @templeteString = KString.removeLastRET(@templeteString)
    end


  end

  # oneTagList = KSUtil.oneTags
  
  # oneTagList.each do |list|
  #   Object.const_set list, Class.new(JWOneTag){}
  # end
end

