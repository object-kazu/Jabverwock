require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample04/"
  
  RSpec.describe sampleName do

    b = JK.body
    h = JK.html

    pp = JK.p.contentIs "段落の中で<br>改行をするときは<br>&lt;br&gt;タグを<br>使用します。"
    
    b.addChild pp
    h.addChild b
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
  end

  
  
end
  
