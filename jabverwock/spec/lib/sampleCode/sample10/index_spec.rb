require 'spec_helper'
require_relative '../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/" 
  sampleName = "sample10/"
  
  RSpec.describe sampleName do

    h = JK.html
    b = JK.body
    
    brTag = JK.br
    bold = JK.b.contentIs "これは太字です。"
    strong = JK.strong.contentIs "このテキストは強調されて表示されます。"
    em = JK.em.contentIs "このテキストは強調されて表示されます。"
    ii = JK.i.contentIs "このテキストは斜体です。"
    sm = JK.small.contentIs "このテキストは一回り小さく表示されます。"
    sub = JK.sub.contentIs "下付き文字"
    pSub = JK.p.contentIs "このテキストは" + sub.tgStr + "を含んでいます。"
    sup = JK.sup.contentIs "上付き文字"
    pSup = JK.p.contentIs "このテキストは" + sup.tgStr + "を含んでいます。"

    ans = JWS.build [h,
                     [b,
                      [bold,brTag,
                       strong,brTag,
                       em,brTag,
                       ii,brTag,
                       sm,brTag,
                       pSub,brTag,
                       pSup,brTag
                      ]
                     ]
                    ]
    ans.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)

    # show diff
    KSUtil.myDiff (testFolderPath + sampleName)
   end

  
  
end
  
