
if $FOR_GEM
  
  require "global/globalDef"
  require "js/jsBase"
  require "js/jsDocument"
  
else
  require_relative "../global/globalDef" 
  require_relative "./jsBase"
  require_relative "./jsDocument"
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension

  
  
  #This class express JS Document class
  class JsFunction < JsBase
    attr_accessor :result, :query
    
    def initialize(*inits)
      super inits
      @obj = "function"
    end

    def define(name, *args, code)
      f =  "#{@obj} #{name.to_s}(#{args.join(", ")}){
      #{code}
      }"

      @units.update seqHash(f)
    end
    
    
  end


  
end
