
if $FOR_GEM
  
  require "global/globalDef"
  require 'js/jsDocument'
else
  require_relative "../global/globalDef" 
  require_relative "./jsDocument" 
  
end


module Jabverwock
  using StringExtension
  using ArrayExtension
  using SymbolExtension

  # var myCollection = document.getElementsByTagName("p");
  # document.getElementById("demo").innerHTML =
  # "The innerHTML of the second paragraph is: " +
  # myCollection[0].innerHTML;

  # jdoc.byID.is_var(:myCollection)
  # a = var(:myCollection)[0].innerHTML
  # collect(:myCollection)[0].innerHTML
  
  #This class express JS Document class
  class JsVariable < Element

    attr_accessor :name, :statement
    attr_reader :expression
    
    def initialize()
      @name = ""
      @statement = ""
    end

    def test
      yield self
    end
  end

  

end

# # coding: utf-8
# require 'rexml/document'

# #変数
# val = 1

# doc = REXML::Document.new
# # doc << REXML::XMLDecl.new('1.0', 'UTF-8')

# frr = doc.add_element("aaa").add_text("#{val}").add_attribute('id','sample')

# # doc.write STDOUT
# # puts "\n"
# # puts doc

# puts doc

