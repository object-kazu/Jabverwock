require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
  def self.header
    head = HEAD.new
    
    title = TITLE.new
    title.content = "This is my first page"
    head.addChild title

    head
  end
  
  def self.bodier
    body = BODY.new    
    heading = HEADING.new(1).contentIs "Home page"
    heading.css.color("green")
    
    body.addChild heading
    
    body
  end
  
  html= HTML.new
  
  html.addChild header
  html.addChild bodier

  html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
  # show diff
    currnt = Dir.pwd
  now = "css_first_test"
  testFolderPath = currnt + "/spec/lib/css/#{now}/"
  KSUtil.myDiff (testFolderPath)


     
  end
end

