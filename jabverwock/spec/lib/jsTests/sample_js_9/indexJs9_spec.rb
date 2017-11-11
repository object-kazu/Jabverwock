
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'js 9 test' do
    

    class << self
      
      
      
      def bodier
        body = BODY.new
        
        ### JSFunction ####
        h1 = HEADING.new.attr(:id__myBtn).contentIs "Click on this text!"
        fmain = "alert(\"hello world\");"
        func = "function(){#{fmain}}"
        h1.js.doc.byID.addEventListener(click:"#{func}")
        
        mf = "myFunc"
        h1.js.doc.byID.addEventListener(click_:"#{mf}")
        h1.js.func.define mf.to_sym,fmain
        
        body.addChild h1

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
