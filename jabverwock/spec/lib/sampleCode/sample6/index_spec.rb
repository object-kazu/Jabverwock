require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample6/"
  
  RSpec.describe sampleName do

    h = JK.html
    b = JK.body

    message = "&lt;hr&gt;タグは、水平線（区切り線）を定義します。"
    txt = "これは段落です。"
    pm = JK.p.contentIs message
    arr = []
    3.times{
      hr = JK.hr
      pp = JK.p.contentIs txt
      hr.addMember pp
      arr << hr
    }

    arr.unshift pm
    
    ans = JWS.build [h,
                    [b,
                     arr
                    ]
                   ]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
