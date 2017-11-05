require "global/globalDef"
require "js/jsBase"


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
      @units.update seqHash v      
      self
    end

    ### collection ###
    def cut
      exp = KSHash.lastHashValue @units
      KSHash.removeLastHashValue @units
      KString.remove_Js_Cmd_End(exp)
    end


    
    def collectionLength(name)
      l = "#{name.to_s}.length"
      @units.update seqHash l
      self
    end
    
    def collection(name, index = -1, *exp)

      if index == -1
        c ="#{name.to_s}"
        @units.update seqHash c
        return self
      end
      
      if exp.count == 0
        c ="#{name.to_s}[#{index}]"
        @units.update seqHash c
        return self
      end
      
      c ="#{name.to_s}[#{index}].#{exp.first}"
      @units.update seqHash c
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
