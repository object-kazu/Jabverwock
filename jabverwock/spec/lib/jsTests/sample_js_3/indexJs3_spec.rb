
require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock

  RSpec.describe 'js 3 test' do
    
    class << self
      
      
      def header
        head = HEAD.new
        title = TITLE.new
        title.content = "Hello world"
        head.addChild title
        
        head.js.doc.write("hello world")
        head
      end

      
      def bodier
        body = BODY.new
        para = P.new.contentIs "yes"
        body.addChild para
        body.js.doc.write("next world")
        
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
