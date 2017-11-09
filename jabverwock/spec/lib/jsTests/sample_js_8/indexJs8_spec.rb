
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    class << self
      def bodier
        body = BODY.new
        
        ### JSFunction ####
        h1 = HEADING.new.attr(:onclick,"changeText(this)").contentIs "Click on this text!"
        h1.js.func.define :changeText,:id, "id.innerHTML = \"Ooops!\";"

        ### onchange attr ###
        input = INPUT.new.attr(:type__text, :id__frame, :onchange, "upperCase()")
        
        body.addChild h1
        body.addChild input
        body
      end
    end
    
    
    html = HTML.new
    html.addChild bodier
    
    doc = DOCTYPE.new
    doc.addMember html
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff   
    KSUtil.myDiff(__FILE__)
    
  end
end
