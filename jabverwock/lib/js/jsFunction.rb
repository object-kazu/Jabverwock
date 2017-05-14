
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
  class JsFunction < JsBase
    attr_accessor :result, :query
    
    def initialize(*inits)
      super inits
      @obj = "function"
    end

    def define(name,code,*args)
      @orders << "#{@obj} #{name.to_s}(#{args.join(", ")}){
      #{code}\n}"
    end

    
    
  end


  
end
