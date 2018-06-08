require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample05/"
  
  RSpec.describe sampleName do

    b = JK.body
    h = JK.html
    
    hs = []
    # h1 = JK.heading(1).contentIs "これは見出し1です"
    # h2 = JK.heading(2).contentIs "これは見出し2です"
    # ...
    
    for i in(1..6)
      hs << JK.heading(i).contentIs("これは見出し#{i}です")
    end
    hs << JK.p.contentIs( "単に太字にするために使用せず、見出しのためだけに&lt;h1&gt;～&lt;h6&gt;タグを使ってくだい。太字にするためには他のタグを使用します。")

    h.addChildren b,hs
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
