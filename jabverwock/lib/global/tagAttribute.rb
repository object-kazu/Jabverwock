require "global/globalDef"
require "global/tagAttributeTempelete"


module Jabverwock
  using StringExtension
  
  # This class is control tagAttribute(selector), such as id, name, class, lang and so on.
  class TagAttribute < TagAttributeTemplete
    
    # caution! do not use "__", because JW class may split symbole like ":id_test"  as "id" and "test"
    list  = [:accept,:accept_charset, :accesskey,:action, :align, :alt, :async, :autocomplete,:autofoucus,:autoplay]
    list += [:border,:buffered, :bgcolor,:background]
    list += [:challenge,:charset,:checked,:cite,:cls,:code,:codebase,:color,]
    list += [:cols,:colspan,:content,:contenteditable,:contextmenu,:controls,:coords,:crossorigin,:cellpadding, :cellspacing,]
    list += [:data,:datetime,:default,:defer,:dir,:disable,:dirname,:download,:draggable,:dropzone,]
    list += %i(enctype)
    list += %i(for form formaction)
    list += [:font_family, :font_size]
    list += %i(headers high hreflang http_equiv)
    list += [:hidden,:http_equiv, :href,:height,]
    list += [:id,:inputmode,]
    list += %i(icon integrity ismap itemprop)
    list += %i(keytype kind)
    list += %i(label language loop low)
    list += [:lang, :line_height,:list]
    list += %i(manifest maxlength minlength media muted)
    list += [:margin, :maxlength, :minlength,:max, :min, :multiple, :method]
    list += %i(novalidate)
    list += [:name,] 
    list += [:onclick, :onchange]
    list += %i(open optimum)
    list += [:position,:pattern,:placeholder,]
    list += %i(ping poster preload)
    list += %i(radiogroup reversed rows )
    list += [:required, :readonly, :rel,:rowspan,]
    list += %i(sandbox scope scoped seamless selected shape sizes slot span srcdoc srclang srcset start summary)
    list += [:spellcheck,:scheme, :style, :size,:src, :step,]
    list += [:target, :type,:tabindex,:title,:translate,]
    list += %i(usemap )
    list += %i()
    list += %i()
    list += %i()
    list += %i(value)
    list += %i(width wrap)

    self.define_attributes list
       
    def initialize
      super
    end
   
  end
  
end

