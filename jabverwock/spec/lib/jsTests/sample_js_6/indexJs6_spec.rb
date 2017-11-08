
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    class << self
      
      
      def header
        head = HEAD.new
        title = TITLE.new
        title.content = "hello world"
        head.addChild title
        
        head
      end

      
      def bodier
        body = BODY.new

        p1 = P.new.attr(:id__p2).contentIs "hello world,again"
        p1.js.doc.byID.style(color:"blue")
        
        p2 = P.new.attr(:id__test).contentIs "The paragraph above was changed by a script."
        p2.js.doc.byID.style(color:"red")
        
        body.addChildren p1,p2
        body
      end

      
      
    end
    
    
    html = HTML.new
    
    html.addChild header
    html.addChild bodier
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
