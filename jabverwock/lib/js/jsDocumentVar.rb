if $FOR_GEM  
  require "global/globalDef"
  require "js/JsVar"
  require "js/jsDocument"
else
  require_relative "../global/globalDef"
  require_relative "./jsVar"
  require_relative "./jsDocument"
end

#   @js.doc_var.createElement(:p).is_append.createTextNode("this is new")
#   @js.doc_var.byID.is_append.createElement(:img).setAttribute(id:"js_koneta_01-01".dQuo ,src:"images/js/analysis_back.jpg".dQuo)



module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class is express JS Document with variable class  
  class JsDocumentVar < JsDocument
    # attr_accessor :is
    
    def initialize(*inits)
      super inits
      
      # @is = JsDocument.new inits

    end


    def call (statement)
      v =  eval(statement)
      v.record
    end
    
    # 変数名を自動的に振り分ける
    #   assert_equal(@jsdv.orders[0], "var new_01 = document.createElement('p');")
    #   assert_equal(@jsdv.orders[1], "var new_02 = document.createTextNode('this is new');")      
    #   assert_equal(@jsdv.orders[2], "new_p01.appendChild(nn);")
    # vp.is_append('#{vc}')
    
    ### JsDocument method call ###
    # def method_missing(method, *arg)
    #   if arg.count == 0
    #     p @vp = @is.send(method)
    #   else
    #     p @vp = @is.send(method, *arg)
    #   end
      
    # end

    
   
  end
  
  # a = JsDocumentVar.new
  # a.call:append
# p  a.write("shimizu")
# p  a.record
  
  
 
end

