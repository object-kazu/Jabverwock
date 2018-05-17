require 'spec_helper'
require_relative '../../../../lib/paths'

module Jabverwock

  currnt = Dir.pwd
  testFolderPath = currnt + "/spec/lib/sampleCode/layouts/" 
  sampleName = "page_centering_1/"


  
  RSpec.describe sampleName do
    def makeHEAD
      h = JK.head
      m = JK.meta.attr(:http_equiv, "Content-Type").attr(:content, "text/html").attr(:charset, "Shift_JIS")
      l = JK.link.attr(:rel,"stylesheet").attr(:type,"text/css").attr(:href,"body.css")
      t = JK.title.contentIs"ページのタイトル"
      h.addChild m
      h.addChild l
      h.addChild t
      h
    end
    
    def makeBody
      b = JK.body
      c = JK.comment.contentIs "コンテナ開始"
      e = JK.comment.contentIs "コンテナ終了"
      b.addChildren [c,divContainer,e]
      b
    end

    def divContainer
      c = JK.div.attr(:id__container)
      
      hs = JK.comment.contentIs "ヘッダ開始"
      he = JK.comment.contentIs "ヘッダ終了"
      cs = JK.comment.contentIs "コンテンツ開始"
      ce = JK.comment.contentIs "コンテンツ終了"
      fs = JK.comment.contentIs "フッタ開始"
      fe = JK.comment.contentIs "フッタ終了"
      
      h = JK.div.attr(:id__header)
      h.addChildString "[ヘッダ]"
      
      content = JK.div.attr(:id__contant)
      content.addChildString "[コンテンツ]"
      
      f = JK.div.attr(:id__footer)
      f.addChildString "[フッタ]"
      
      a = JWS.build [c,[
                       hs,h,he,
                       cs,content,ce,
                       fs,f,fe
                     ]]
    end
    
    it "main description" do
     
      html = JK.html.attr(:lang, "ja")
      html.addChild makeHEAD
      html.addChild makeBody
      
      doc = JK.doctype
      doc.type = "HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\""
      doc.addMember html
      
      # #print result
      doc.pressTo(name: 'indexPressed.html', dist: testFolderPath + sampleName)
                   
      # show diff
      KSUtil.myDiff (testFolderPath + sampleName)
    end

    
  end


#     <html lang="ja">
#     <head>

# 	<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
# 	<link rel="stylesheet" type="text/css" href="body.css">

# 	<title>ページのタイトル</title>

#     </head>
#     <body>

# 	<!-- コンテナ開始 -->
# 	<div id="container">


# 	    <!-- ヘッダ開始 -->
# 	    <div id="header">
# 		［ヘッダ］
# 	    </div>
# 	    <!-- ヘッダ終了 -->


# 	    <!-- コンテンツ開始 -->
# 	    <div id="content">
# 		［コンテンツ］
# 	    </div>
# 	    <!-- コンテンツ終了 -->


# 	    <!-- フッタ開始 -->
# 	    <div id="footer">
# 		［フッタ］
# 	    </div>
# 	    <!-- フッタ終了 -->


# 	</div>
# 	<!-- コンテナ終了 -->

#     </body>
# </html>

    
    
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



  
  
end
  
