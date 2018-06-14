require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do

  def self.header
    head = HEAD.new
    title = TITLE.new.contentIs "This is my first page"
    head.addChild title
    head
  end
  
  def self.bodier
    
    body = BODY.new    
    heading = HEADING.new(1).contentIs "This text is red"
    heading.attr(:id, "example1")
    body.addChild heading
    body
  end
  
  html= HTML.new.attr(:id__example2)
  c = CSS.new("#example1").color "blue"
  html.addCss c
  
  html.addChildren header, bodier
      
  html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
  # show diff
  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/css/css_addCss_simple/" 
  KSUtil.myDiff (testFolderPath)
    
  end
end

