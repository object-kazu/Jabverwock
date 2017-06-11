
if $FOR_GEM
  
  require "global/globalDef"
  require "js/jsBase"
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension
  
  #This class express JS Document class
  class JsVar < JsBase
    attr_accessor :result, :query
         
    def initialize(*inits)
      super inits
      @obj = "var"
    end

    
    def is(name,val)
      v = "#{@obj} #{name} = #{val}"
      @units << v
      self
    end

  end

  
  # This class is manage variable in JsDocument
  #  "var new_01 = document.createElement('p');
  #  "var new_02 = document.createTextNode('this is new');
  #  "var new_p01.appendChild(nn);
  #  varNameList = [new_01, new_02, new_p01]
  
  # class Variable < JsBase
    
  #   def initialize(*inits)
  #     super inits
  #     # @delegate = delegate
  #     @varNameList = [] # var name list ex) var a, var bb , ...
      
  #   end

  #       ### jsDocument ####
  #   def createElement(elm)
      
  #   end

  # end
end
