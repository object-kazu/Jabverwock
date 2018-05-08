require 'spec_helper'
require_relative '../../../lib/paths'


  using StringExtension
  using ArrayExtension
  using SymbolExtension

module Jabverwock


  RSpec.describe 'css test' do
    
  # exp.1
  
  html= HTML.new
  head = HEAD.new
  
  title = TITLE.new
  title.content = "This is my first page"
  head.addChild title
  
  body = BODY.new
  c = HEADING.new.contentIs "Hello world" 
  body.addChild c

  html.addChild head
  html.addChild body
  
  
  # exp.2
  
  # def self.header
  #   head = HEAD.new
    
  #   title = TITLE.new
  #   title.content = "This is my first page"
  #   head.addChild title
  #   head
  # end
  
  # def self.bodies
  #   body = BODY.new
  #   c = HEADING.new.contentIs "Hello world" 
  #   body.addChild c
  #   body
  # end

  # html= HTML.new
  # html.addChildren header, bodies
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
