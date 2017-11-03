require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do

  html= HTML.new
  head = HEAD.new
  
  title = TITLE.new
  title.content = "This is my first page"
  head.addChild title
  
  body = BODY.new
  c = P.new.contentIs "Hello world!" 
  body.addChild c

  html.addChild head
  html.addChild body
  
  doc = DOCTYPE.new
  doc.addMember html


    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
  # show diff    
  KSUtil.myDiff(__FILE__)

    
  end
end
