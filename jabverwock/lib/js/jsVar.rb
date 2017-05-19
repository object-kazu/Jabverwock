
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
      @obj = "function"
    end

    def var(name,val)
      v = "var #{name} = #{val}"
      @orders << v
    end

    
    
  end


  
end
