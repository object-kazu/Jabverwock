require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample7/"
  
  RSpec.describe sampleName do

    b = JK.body
    h = JK.html


    co = JK.comment.contentIs "このコメントは表示されません"
    pp = JK.p.contentIs "これは通常の段落です。"
    
    ans = JWS.build [h,
                     [b,
                      [co,pp]
                     ]
                    ]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
