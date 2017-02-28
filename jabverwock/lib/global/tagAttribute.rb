if $FOR_GEM
  
  require "global/globalDef"
  require "global/tagAttributeTempelete"
  
else
  
  require_relative "globalDef"
  require_relative "tagAttributeTempelete"

end




module Jabverwock
  using StringExtension
  
  class TagAttribute < TagAttributeTemplete

    list  = [:id,:cls,:href,:lang, :target]
    list += [:name, :http_equiv,:content,:charset,:scheme]
    list += [:accesskey,:contenteditable,:dir, :hidden, :spellcheck, :style, :tabindex,:title,:translate]
    list += [:rowspan, :colspan]
    list += [:src]
    self.define_attributes list
       
    def initialize
      super
    end

   
  end

  # p a = TagAttribute.new
  # a.id = "test"
  # a.src = "/usr/local/"
  # p a
  
end

