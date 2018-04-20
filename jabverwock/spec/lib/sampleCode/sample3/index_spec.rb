require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample3/"
  
  RSpec.describe sampleName do

    b = JK.body
    h = JK.html

    txt = ["	    この段落の
	    ソースコードには
	    多くの行を含んでいます。
	    しかし、ブラウザはそれを無視します。",

	    "この      段落の
	    ソースコード        には
	    多くの      連続したスペース   を含んでいます。
	    しかし、ブラウザは          連続した複数のスペースを    1つの半角スペースと見なします。",
            "	    段落中の行の数は、あなたのブラウザウィンドウのサイズに依存します。あなたがブラウザウィンドウのサイズを変更すれば、この段落中の行の数が変わるでしょう。"
          ]
    
    3.times{
      text = txt.shift
      pp = JK.p.contentIs text
      b.addChild pp
    }
    
    ans = JWS.build [h, [b]]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
  end

  
  
end
  
