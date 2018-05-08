require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    html = HTML.new  
    body = BODY.new
    
    p1 = P.new.contentIs "this is " << "a".variable
    
    body.addChild p1
    html.addChild body
    
    html.pressConfig(name: 'indexPressed.html', dist: KSUtil.myPATH)
    html.pressInsert("a".varIs "class")
    
    # html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
