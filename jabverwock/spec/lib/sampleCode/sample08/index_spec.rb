require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample8/"
  
  RSpec.describe sampleName do
    
    h = JK.html
    b = JK.body
    b.attr(:bgcolor, "yellow")

    h2 = JK.heading(2).contentIs "黄色の背景色"

    ans = JWS.build [h,
                     [b,
                      [h2]
                     ]
                    ]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
