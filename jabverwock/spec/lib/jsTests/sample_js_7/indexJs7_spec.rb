
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

        h1 = HEADING.new.attr(:id__id1).contentIs "My Heading 1"
        h1s = h1.js.doc.byID.style(color:"red").cut
        
        btn = BUTTON.new.attr(:type__button, :onclick, h1s).contentIs "Click Me!"
        
        body.addChildren [h1, btn]
        body
      end      
    end
    
    
    html = HTML.new
    
    html.addChild bodier
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
