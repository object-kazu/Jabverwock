
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
        div = DIV.new.attr(:id__div1)
        
        p1 = P.new.attr(:id__p1).contentIs "This is a paragraph."
        p2 = P.new.attr(:id__p2).contentIs "This is another paragraph."

        div.jsRead "/Users/shimizukazuyuki/ActiveProject/JabberWockProjects/JabverwockRuby/jabverwock/spec/lib/jsTests/sample_js_13/sample.js"
        div.addChildren p1, p2
        body.addChild div
        body
      end
    end
    
    html = HTML.new
    html.addChild bodier
    
    doc = DOCTYPE.new
    doc.addMember html
    doc.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
