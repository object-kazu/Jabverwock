require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    doc = DOCTYPE.new
    html= HTML.new.contentIs "This is Member."
    doc.addMember html
  
  
    head = HEAD.new
    title = TITLE.new.contentIs "This is Child."
    head.addChild title
  
  
    doc.addMember head 
  
    
    
    doc.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
