require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension
using ArrayExtension
using SymbolExtension

module Jabverwock


  RSpec.describe 'js test 1 test' do
    
    html = HTML.new

    header = HEAD.new
    title = TITLE.new.contentIs "hello world"
    header.addChild title
    
    header.js.doc.write("hello!")
    
    body = BODY.new
    body.js.doc.write("new world")
    
    html.addChild header
    html.addChild body
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)
    
  end
end
