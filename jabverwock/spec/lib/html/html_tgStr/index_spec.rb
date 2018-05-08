require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    html= HTML.new  
    body = BODY.new
    
    bold = B.new.contentIs "test"
    
    pp = P.new.contentIs "This is #{bold.tgStr}"
    body.addChild pp
    html.addChild body
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
