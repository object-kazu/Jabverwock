
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

    def define(name, *args, code)
      f =  "#{@obj} #{name.to_s}(#{args.join(", ")}){
      #{code}
      }"

      @units.update seqHash(f)
    end

    
    # /**
    #  * spanエレメント(オブジェクト)追加
    #  */
    
    # function displayString_createElement() {
    #     var o = document.createElement("span");
    #     o.setAttribute("id", "js_koneta_01-01");
    #     o.innerHTML     = "JavaScript万歳！";
    #     o.style.cssText = "font-weight: bold;"
    #        	     + "font-size: 12pt"
    #        	     + "color: #00ff00";
    #     document.getElementById("js_koneta_01").appendChild(o);
    # }

  end


  
end
