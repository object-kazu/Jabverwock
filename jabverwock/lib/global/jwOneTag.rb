require "global/jwSingle"

module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #this class express ["DOCTYPE","META", "IMG", "LINK", "INPUT"]
  class JWOneTag < JWSingle
    attr_accessor :type
    
    def initialize(style=$SINGLE)
      super
      @type = ""
      @isMulti = $SINGLE # oneTag class do not permit multi style
    end
    
    # overide ##
    def makeTag
      @tagManager.setDocType @type
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

end

