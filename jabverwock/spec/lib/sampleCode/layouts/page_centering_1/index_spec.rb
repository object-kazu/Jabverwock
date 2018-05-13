require 'spec_helper'
require_relative '../../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/layouts/" 
  sampleName = "page_centering_1/"
  
  RSpec.describe sampleName do
    
    #<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    doc = JK.doc
    # h = JK.html
    
    # b = JK.body
    # b.attr(:background, "sample_bg.gif")

    # h3 = JK.heading(3).contentIs "背景画像"
    # pp1 = JK.p.contentIs "GIFやJPEG形式の画像ファイルがHTMLの背景画像として利用できます。"
    # pp2 = JK.p.contentIs "画像の大きさがページの大きさよりも小さいときには、画像自体が繰り返されて表示されます。"
    # ans = JWS.build [h,
    #                  [b,
    #                   [h3,pp1,pp2]
    #                  ]
    #                 ]


    #print result
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
