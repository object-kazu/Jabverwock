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

  singleList = ["P", "A","B","I","STRONG","BR","BLOCKQUOTE","DT", "DD","DOCTYPE","HEADING","IMAGE",
               "LIST_ITEM","META","TITLE",]
  
  singleList.each do |list|
    Object.const_set list, Class.new(JWSingle){
    
      attr_accessor :name
      def initialize
        super
        @name = self.class.name.downcase
        @css = CSS.new("#{name}")
      end
    }
  end

  
  # p a = P.new 
  # p b = B.new
  # p b.name
  # p b.css
  # p b.cssArray
  
  # c = JWCSS.new
  # p c.css
  # p c.cssArray
  # p c.pressDefault
  
end
