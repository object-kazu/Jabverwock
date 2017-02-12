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
      end
    }
  end

  
  # p a = Car.new # => #<Car:0x007f878b8742d0 @name="car">
  # p b = Train.new
  # p b = Train.new# => #<Train:0x007f878b86f9b0 @name="train">
  # p b.name# => "train"
  # p b.size# => nil
  # => nil

end

