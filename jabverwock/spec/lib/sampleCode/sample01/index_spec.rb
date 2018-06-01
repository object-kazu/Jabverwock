require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  
  
  RSpec.describe 'sample1, another method, use structure' do

    
    b = JK.body.contentIs "body要素の内容は、ブラウザに表示されます。"
    h = JK.html
    h.addChild h
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + "sample01/")

    # show diff
    KSUtil.myDiff (testFolderPath + "sample1/")
  end

  
  
end
  
