require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
  def self.header
    head = HEAD.new
    head
  end
  
  def self.bodier
    body = BODY.new
    div = DIV.new
    div.css.name = "div.sample h2 ~ p"
    div.css.color "red"
    body.addChild div
    body
  end
  
  html= HTML.new  
  html.addChildren header, bodier

  html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
  # show diff    
  currnt = Dir.pwd
  now = "css_complicatedName"
  testFolderPath = currnt + "/spec/lib/css/#{now}/"
  KSUtil.myDiff (testFolderPath)
  
  
  end
end
