require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  
  RSpec.describe 'sample1' do

    b = JK.body.contentIs "body要素の内容は、ブラウザに表示されます。"
    h = JK.html
    h.addChild b
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + "sample1/")
    
    
    # show diff
    KSUtil.myDiff (testFolderPath + "sample1/")
  end  
  
end
  
