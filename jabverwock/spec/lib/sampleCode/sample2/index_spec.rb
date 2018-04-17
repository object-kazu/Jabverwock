require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample2/"
  
  # RSpec.describe sampleName do

  #   b = JK.body
  #   h = JK.html

  #   3.times{
  #     pp = JK.p.contentIs "これは段落です。"
  #     b.addChild pp
  #   }
    
  #   pp = JK.p.contentIs "p（段落）要素は、&lt;p&gt;タグによって定義されます。"
  #   b.addChild pp
    
  #   ans = JWS.build [h, [b]]
  #   ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

  #   # show diff
  #   KSUtil.myDiff (testFolderPath + sampleName)
  # end
  
  #refactoring
  RSpec.describe sampleName do

    b = JK.body
    h = JK.html

    txt = %w(これは段落です。 p（段落）要素は、&lt;p&gt;タグによって定義されます。)
    
    3.times{
      pp = JK.p.contentIs txt[0]
      b.addChild pp
    }
    
    pp = JK.p.contentIs txt[1]
    b.addChild pp
    
    ans = JWS.build [h, [b]]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
  end

  
  
end
  
