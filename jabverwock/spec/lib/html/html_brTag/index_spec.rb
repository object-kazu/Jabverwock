require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    html= HTML.new  
    body = BODY.new
    
    br = BR.new
    p1 = P.new.contentIs "this is " << br.tgStr << "br class"
    p2 = P.new.contentIs "this is #{$BR}br string"
    p3 = P.new.contentIs("this is last").withBreak
    
    body.addChildren p1, p2, p3
    html.addChild body
    
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
