
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

        img = IMG.new.attr(:id,"myImage").attr(:src, "simple.gif")
        img.js.doc.byID.src("landscape.jpg".dQuo)
        
        body.addChild img
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
