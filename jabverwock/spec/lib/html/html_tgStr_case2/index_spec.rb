require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    body = BODY.new
    
    a = A.new.contentIs("test").attr(:href,"www://")
    pp = P.new.contentIs "What is this? #{a.tgStr}"
    body.addChild pp

    html= HTML.new  
    html.addChild body
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
