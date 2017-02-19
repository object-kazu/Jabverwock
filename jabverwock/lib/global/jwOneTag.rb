#require '../../lib/global/jwCSS'  
require "global/jwCSS"

module Jabverwock
  using StringExtension
  
  class JWOneTag < JWCSS
    attr_accessor :doctype
    
    def initialize
      super
      @doctype = ""
    end
    
    ## overide ##
    def makeTag
      @tagManager.setDocType @doctype
      @tagManager.openString
    end
    
    ## overide ##
    def makeResult
      @templeteString = @tagManager.tempOpenString
      @templeteString = KString.removeLastRET(@templeteString)
    end
    
  end

  oneTagList = ["DOCTYPE","META"]
  
  oneTagList.each do |list|
    Object.const_set list, Class.new(JWOneTag){
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{name}")
      end
    }
  end

  
  # p a = DOCTYPE.new 
  # p a.pressDefault
  
  # c = JWCSS.new
  # p c.css
  # p c.cssArray
  # p c.pressDefault
  
end

