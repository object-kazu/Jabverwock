if $FOR_GEM
  
  require "global/globalDef"
  require "global/tagAttributeTempelete"
  
else
  
  require_relative "globalDef"
  require_relative "tagAttributeTempelete"

end




module Jabverwock
  using StringExtension
  
  # This class is control tagAttribute(selector), such as id, name, class, lang and so on.
  class TagAttribute < TagAttributeTemplete
    
    # caution! do not use "__", because JW class may split symbole like ":id_test"  as "id" and "test"
    list  = [:accesskey,:autofoucus, :alt,:autocomplete,:action]
    list += [:border,]
    list += [:contenteditable,:cls,:content,:charset,:cellpadding,:checked, :cellspacing,:colspan,]
    list += [:dir,:disable,:dirname,]
    list += []
    list += [:font_family, :font_size, :form,]
    list += []
    list += []
    list += [:hidden,:http_equiv, :href,:height,]
    list += [:id,:inputmode,]
    list += []
    list += [:lang, :line_height,:list]
    list += [:margin, :maxlength, :minlength,:max, :min, :multiple, :method]
    list += []
    list += [:name,] 
    list += [:onclick, :onchange]
    list += [:position,:pattern,:placeholder,]
    list += []
    list += []
    list += [:required, :readonly, :rel,:rowspan,]
    list += [:spellcheck,:scheme, :style, :size,:src, :step,]
    list += [:target, :type,:tabindex,:title,:translate,]
    list += []
    list += []
    list += []
    list += []
    list += []
    list += [:value, ]
    list += [ :width,]

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

