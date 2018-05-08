require 'spec_helper'
require_relative '../../../lib/paths'

using StringExtension

module Jabverwock


  RSpec.describe 'css test' do
    
    html= HTML.new
    
    body = BODY.new
    h1 = HEADING.new.contentIs "Hello world!" 
    h2 = HEADING.new(2).contentIs "See you again"
    
    body.addChildren h1,h2
    html.addChild body
    
    html.pressTo(name: 'indexPressed.html', dist: KSUtil.pathForTest(__FILE__))
    
    # show diff    
    KSUtil.myDiff(__FILE__)

  end
end
