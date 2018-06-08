require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample08/"
  
  RSpec.describe sampleName do
    
    h = JK.html
    b = JK.body
    b.attr(:bgcolor, "yellow")

    h2 = JK.heading(2).contentIs "黄色の背景色"
    
    b.addChild h2
    h.addChild b
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
