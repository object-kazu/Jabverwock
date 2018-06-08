require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample09/"
  
  RSpec.describe sampleName do
    
    h = JK.html
    b = JK.body
    b.attr(:background, "sample_bg.gif")

    h3 = JK.heading(3).contentIs "背景画像"
    pp1 = JK.p.contentIs "GIFやJPEG形式の画像ファイルがHTMLの背景画像として利用できます。"
    pp2 = JK.p.contentIs "画像の大きさがページの大きさよりも小さいときには、画像自体が繰り返されて表示されます。"
    b.addChildren h3,pp1,pp2
    h.addChild b
    
    # ans = JWS.build [h,
    #                  [b,
    #                   [h3,pp1,pp2]
    #                  ]
    #                 ]
    h.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
