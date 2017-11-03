require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do

  class << self
    
    
    def header
      header = HEAD.new
    end
    
    
    def bodier
      body = BODY.new
      
      sym = :id__container
      div = DIV.new.attr(sym)
      
      div.css.name = sym
      div.css.width("400px").height("400px").position("relative").background("yellow")
      
      sym_a = :id__animate
      divin = DIV.new.attr(sym_a).contentIs "My animate will go here"
      divin.css.name = sym_a
      divin.css.width("50px").height("50px").position("absolute").background("red")
      
      div.addChild divin
      body.addChild div
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
